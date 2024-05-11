use std::env;
use std::time::Duration;

use clap::{
    arg,
    builder::{BoolishValueParser, EnumValueParser},
    command, value_parser, Arg,
};

use crate::{direction::Direction, level_style::LevelStyle};

pub struct LogicArgs {
    pub exact: Option<u32>,
    pub direction: Option<Direction>,
    pub steps: u32,
    pub segments: u32,
}

pub struct UxArgs {
    pub print: bool,
    pub fade: Duration,
    pub notify: bool,
    pub level_style: LevelStyle,
    pub timeout: Duration,
}

pub struct Args {
    pub logic: LogicArgs,
    pub ux: UxArgs,
}

fn args() -> impl IntoIterator<Item = Arg> {
    [
        arg!(-e --exact <NUMBER> "The exact brightness step to set")
            .value_parser(value_parser!(u32))
            .conflicts_with("direction"),
        //
        arg!(-d --direction <VARIANT> "Where to turn the brightness to")
            .value_parser(EnumValueParser::<Direction>::new()),
        //
        arg!(-s --steps <NUMBER> "How many segments to skip")
            .value_parser(value_parser!(u32))
            .default_value("1")
            .requires("direction"),
        //
        arg!(-S --segments <NUMBER> "The number of steps between 0% and 100%")
            .value_parser(value_parser!(u32).range(1..))
            .default_value("10"),
        //
        arg!(-p --print "Print the brightness level to standard output"),
        //
        arg!(-f --fade <HUMANTIME> "How long to show the fade effect for")
            .value_parser(humantime::parse_duration)
            .default_value("150ms"),
        //
        arg!(-n --notify <BOOLISH> "Whether to show a notification")
            .value_parser(BoolishValueParser::new())
            .default_value("true")
            .hide_possible_values(true),
        //
        arg!(-l --"level-style" <VARIANT> "The brightness level style")
            .value_parser(EnumValueParser::<LevelStyle>::new())
            .default_value("percent"),
        //
        arg!(-t --timeout <HUMANTIME> "How long to show the notification for (0 - forever)")
            .value_parser(humantime::parse_duration)
            .default_value("1sec"),
    ]
}

impl Args {
    pub fn build() -> Self {
        const ABOUT: &str = include_str!("../about.txt");
        const LONG_ABOUT: &str = include_str!("../long-about.txt");

        let matches = command!()
            .about(ABOUT)
            .long_about(LONG_ABOUT)
            .args(args())
            .arg_required_else_help(true)
            .get_matches();

        const HAS_DEFAUT: &str = "the argument has a default value";

        Self {
            logic: LogicArgs {
                exact: matches.get_one("exact").copied(),
                direction: matches.get_one("direction").copied(),
                steps: *matches.get_one("steps").expect(HAS_DEFAUT),
                segments: *matches.get_one("segments").expect(HAS_DEFAUT),
            },
            ux: UxArgs {
                print: matches.get_flag("print"),
                fade: *matches.get_one("fade").expect(HAS_DEFAUT),
                notify: matches.get_flag("notify"),
                level_style: *matches.get_one("level-style").expect(HAS_DEFAUT),
                timeout: *matches.get_one("timeout").expect(HAS_DEFAUT),
            },
        }
    }
}

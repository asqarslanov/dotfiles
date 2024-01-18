/*
[package]
name = "brightness"
version = "2024.1.18"
edition = "2021"

[dependencies]
clap = { version = "4.4.18", features = ["cargo"] }
humantime = "2.1.0"
indoc = "2.0.4"
notify-rust = "4.10.0"
*/

use clap::{
    arg,
    builder::{BoolishValueParser, EnumValueParser, PossibleValue},
    command, value_parser, ValueEnum,
};
use indoc::indoc;
use notify_rust::{
    Hint::{Custom, CustomInt},
    Notification,
};
use std::env;
use std::error;
use std::io;
use std::process::Command;
use std::time::Duration;

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

impl Args {
    fn cmd() -> clap::Command {
        command!()
            .about(indoc! {"
                Adjusts screen brightness in accordance with human perception.
                Dependencies: `brillo`, `pkexec`.

                Run `brightness --help | less` to see some examples.\
            "})
            .long_about(indoc! {"
                Adjusts screen brightness in accordance with human perception.
                Dependencies: `brillo`, `pkexec`.

                Examples:

                > Turn brightness 10% up/down applying the fade effect and calling
                  a system notification without printing anything to the terminal
                  (your bread-and-butter):
                $ brightness -d up
                $ brightness --direction down

                > Output the current brightness percentage to the terminal:
                $ brightness -pn no -l percent
                $ brightness --print --notify=\"no\" --level=\"percent\"

                > Set brightness level to 50% with no fade effect and notification:
                $ brightness -n=off -e=50 -S=100 -f=0s
                $ brightness --notify \"off\" --exact \"50\" --segments \"100\" --fade \"0sec\"

                > Divide the \"progress bar\" by 8 segments, increase brightness level
                  by 2 segments, and call a persistent system notification.
                $ brightness -S 8 -s 2 -d up -t 0nsec
                $ brightness --segments=8 --steps=2 -direction=up --timeout=0ns\
            "})
            .arg(
                arg!(-e --exact <NUMBER> "The exact brightness step to set")
                    .value_parser(value_parser!(u32))
                    .conflicts_with("direction"),
            )
            .arg(
                arg!(-d --direction <VARIANT> "Where to turn the brightness to")
                    .value_parser(EnumValueParser::<Direction>::new()),
            )
            .arg(
                arg!(-s --steps <NUMBER> "How many segments to skip")
                    .value_parser(value_parser!(u32))
                    .default_value("1")
                    .requires("direction"),
            )
            .arg(
                arg!(-S --segments <NUMBER> "The number of steps between 0% and 100%")
                    .value_parser(value_parser!(u32).range(1..))
                    .default_value("10"),
            )
            .arg(arg!(-p --print "Print the brightness level to standard output"))
            .arg(
                arg!(-f --fade <HUMANTIME> "How long to show the fade effect for")
                    .value_parser(humantime::parse_duration)
                    .default_value("100ms"),
            )
            .arg(
                arg!(-n --notify <BOOLISH> "Whether to show a notification")
                    .value_parser(BoolishValueParser::new())
                    .default_value("true")
                    .hide_possible_values(true),
            )
            .arg(
                arg!(-l --"level-style" <VARIANT> "The brightness level style")
                    .value_parser(EnumValueParser::<LevelStyle>::new())
                    .default_value("ratio"),
            )
            .arg(
                arg!(-t --timeout <HUMANTIME> "How long to show the notification for (0 - forever)")
                    .value_parser(humantime::parse_duration)
                    .default_value("1sec"),
            )
            .arg_required_else_help(true)
    }

    pub fn build() -> Self {
        let matches = Self::cmd().get_matches();

        Self {
            logic: LogicArgs {
                exact: matches.get_one("exact").copied(),
                direction: matches.get_one("direction").copied(),
                steps: *matches.get_one("steps").expect("has a default value"),
                segments: *matches.get_one("segments").expect("has a default value"),
            },
            ux: UxArgs {
                print: matches.get_flag("print"),
                fade: *matches.get_one("fade").expect("has a default value"),
                notify: matches.get_flag("notify"),
                level_style: *matches.get_one("level-style").expect("has a default value"),
                timeout: *matches.get_one("timeout").expect("has a default value"),
            },
        }
    }
}

#[derive(Clone, Copy)]
pub enum Direction {
    Up,
    Down,
}

impl ValueEnum for Direction {
    fn value_variants<'a>() -> &'a [Self] {
        &[Self::Up, Self::Down]
    }

    fn from_str(input: &str, ignore_case: bool) -> Result<Self, String> {
        let input = if ignore_case {
            input.to_lowercase()
        } else {
            input.to_string()
        };

        Ok(match input.as_str() {
            "up" => Self::Up,
            "down" => Self::Down,
            _ => unreachable!("clap should catch errors before"),
        })
    }

    fn to_possible_value(&self) -> Option<PossibleValue> {
        Some(PossibleValue::new(match self {
            Self::Up => "up",
            Self::Down => "down",
        }))
    }
}

#[derive(Clone, Copy)]
pub enum LevelStyle {
    Step,
    Ratio,
    Percent,
}

impl ValueEnum for LevelStyle {
    fn value_variants<'a>() -> &'a [Self] {
        &[Self::Step, Self::Ratio, Self::Percent]
    }

    fn from_str(input: &str, ignore_case: bool) -> Result<Self, String> {
        let input = if ignore_case {
            input.to_lowercase()
        } else {
            input.to_string()
        };

        Ok(match input.as_str() {
            "step" => Self::Step,
            "ratio" => Self::Ratio,
            "percent" => Self::Percent,
            _ => unreachable!("clap should catch errors before"),
        })
    }

    fn to_possible_value(&self) -> Option<PossibleValue> {
        Some(PossibleValue::new(match self {
            Self::Step => "step",
            Self::Ratio => "ratio",
            Self::Percent => "percent",
        }))
    }
}

pub struct Value {
    raw: u32,
    step: u32,
    segments: u32,
    x_max: f32,
}

impl Value {
    pub fn current_with_segments(segments: u32) -> Result<Self, io::Error> {
        let max_raw = Self::max_raw()?;
        let x_max = Self::x_max(max_raw);
        let current_raw = Self::current_raw(segments, max_raw, x_max)?;

        Ok(Self {
            raw: current_raw,
            step: Self::raw_to_step(current_raw, segments, x_max),
            segments,
            x_max,
        })
    }

    pub fn with_step_and_segments(step: u32, segments: u32) -> Result<Self, io::Error> {
        let step = step.clamp(0, segments);

        let max_raw = Self::max_raw()?;
        let x_max = Self::x_max(max_raw);

        Ok(Self {
            raw: Self::step_to_raw(step, segments, x_max),
            step,
            segments,
            x_max,
        })
    }
}

impl Value {
    pub fn new_change_step(&self, f: impl FnOnce(u32) -> u32) -> Self {
        let step = f(self.step).clamp(0, self.segments);

        Self {
            raw: Self::step_to_raw(step, self.segments, self.x_max),
            step,
            segments: self.segments,
            x_max: self.x_max,
        }
    }
}

impl Value {
    fn current_raw(segments: u32, max_raw: u32, x_max: f32) -> Result<u32, io::Error> {
        let output_raw = Command::new("pkexec")
            .args(["brillo", "-G", "-r"])
            .output()?
            .stdout;

        let output = unsafe { String::from_utf8_unchecked(output_raw) };

        let raw: u32 = output
            .trim()
            .parse()
            .expect("`brillo` should output a number");

        Ok(Self::raw_to_step_raw(raw, segments, max_raw, x_max))
    }

    fn max_raw() -> Result<u32, io::Error> {
        let output_raw = Command::new("pkexec")
            .args(["brillo", "-m", "-r"])
            .output()?
            .stdout;

        let output = unsafe { String::from_utf8_unchecked(output_raw) };

        let max_raw: u32 = output
            .trim()
            .parse()
            .expect("`brillo` should output a number");

        Ok(max_raw)
    }
}

impl Value {
    fn percent(&self) -> u32 {
        let ratio = self.step as f32 / self.segments as f32;
        (100.0 * ratio).round() as u32
    }

    fn x_max(max_raw: u32) -> f32 {
        (max_raw as f32).log2()
    }
}

impl Value {
    fn raw_to_step(raw: u32, segments: u32, x_max: f32) -> u32 {
        let x = (raw as f32).log2() / x_max;
        let step = (x * segments as f32).round() as u32;

        step.clamp(0, segments)
    }

    fn step_to_raw(step: u32, segments: u32, x_max: f32) -> u32 {
        let step = step.clamp(0, segments);

        let x = (step as f32 / segments as f32) * x_max;
        let raw = 2_f32.powf(x).round();

        raw as u32
    }

    fn raw_to_step_raw(raw: u32, segments: u32, max_raw: u32, x_max: f32) -> u32 {
        let raw = raw.clamp(1, max_raw);

        let x = (raw as f32).log2() / x_max;
        let step = (x * segments as f32).round();
        let x = (step / segments as f32) * x_max;
        let raw = 2_f32.powf(x).round() as u32;

        raw.clamp(1, max_raw)
    }
}

impl Value {
    pub fn apply(&self, args: &UxArgs) -> Result<(), Box<dyn error::Error>> {
        let percent = self.percent();

        if args.print {
            println!(
                "{}",
                match args.level_style {
                    LevelStyle::Step | LevelStyle::Ratio => self.step,
                    LevelStyle::Percent => percent,
                }
            );
        }

        if args.notify {
            Notification::new()
                .summary("Brightness")
                .body(&match args.level_style {
                    LevelStyle::Step => format!("{}", self.step),
                    LevelStyle::Ratio => format!("{}/{}", self.step, self.segments),
                    LevelStyle::Percent => format!("{}%", percent),
                })
                .timeout(args.timeout)
                .hint(CustomInt(String::from("value"), percent as i32))
                .hint(Custom(
                    String::from("x-canonical-private-synchronous"),
                    String::from("Brightness"),
                ))
                .show()?;
        }

        Command::new("pkexec")
            .args([
                "brillo",
                "-S",
                &self.raw.to_string(),
                "-r",
                "-u",
                &args.fade.as_micros().to_string(),
            ])
            .spawn()?
            .wait()?;

        Ok(())
    }
}

fn main() -> Result<(), Box<dyn error::Error>> {
    let args = Args::build();

    let value = match args.logic.exact {
        Some(exact) => Value::with_step_and_segments(exact, args.logic.segments)
            .expect("`brillo` and `pkexec` should work"),

        None => {
            let value = Value::current_with_segments(args.logic.segments)
                .expect("`brillo` and `pkexec` should work");

            match args.logic.direction {
                Some(direction) => match direction {
                    Direction::Up => value.new_change_step(|step| step + args.logic.steps),
                    Direction::Down => value.new_change_step(|step| {
                        step.checked_sub(args.logic.steps).unwrap_or_default()
                    }),
                },
                None => value,
            }
        }
    };

    value.apply(&args.ux)
}

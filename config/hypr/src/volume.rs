/*
[package]
name = "volume"
version = "2023.12.14"
edition = "2021"

[dependencies]
clap = { version = "4.4.11", features = ["cargo"] }
notify-rust = "4.10.0"
*/

use clap::{
    arg,
    builder::{BoolishValueParser, EnumValueParser, PossibleValue},
    command, value_parser, ValueEnum,
};
use notify_rust::{
    Hint::{Custom, CustomInt},
    Notification,
    Timeout::Milliseconds,
};
use std::process::Command;

#[derive(Clone)]
enum Action {
    Up,
    Down,
    Mute,
    Ignore,
}

impl ValueEnum for Action {
    fn value_variants<'a>() -> &'a [Self] {
        &[Self::Up, Self::Down, Self::Mute, Self::Ignore]
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
            "mute" => Self::Mute,
            "ignore" => Self::Ignore,
            _ => unreachable!("clap should catch errors before"),
        })
    }

    fn to_possible_value(&self) -> Option<PossibleValue> {
        Some(PossibleValue::new(match self {
            Self::Up => "up",
            Self::Down => "down",
            Self::Mute => "mute",
            Self::Ignore => "ignore",
        }))
    }
}

fn execute_wpctl(args: &[&str]) -> Vec<u8> {
    Command::new("wpctl")
        .args(args)
        .output()
        .expect("`wpctl` should work")
        .stdout
}

enum Device {
    DefaultAudioSink,
    DefaultAudioSource,
}

impl Device {
    fn low_level_name(&self) -> &str {
        match self {
            Self::DefaultAudioSink => "@DEFAULT_AUDIO_SINK@",
            Self::DefaultAudioSource => "@DEFAULT_AUDIO_SOURCE@",
        }
    }

    fn high_level_name(&self) -> &str {
        match self {
            Self::DefaultAudioSink => "Speakers",
            Self::DefaultAudioSource => "Microphone",
        }
    }

    fn apply(&self, action: &Action, step: i32, max: i32, notify: bool) {
        if let Action::Ignore = action {
            return;
        }

        let output = execute_wpctl(&["get-volume", self.low_level_name()]);

        // Can either be
        // `Volume: {value}`
        // or
        // `Volume: {value} [MUTED]`.
        let output = unsafe { String::from_utf8_unchecked(output) };

        let mut output = output.split_ascii_whitespace().peekable();
        const VOLUME_POSITION: usize = 1;

        let percent = output
            .nth(VOLUME_POSITION)
            .expect("`wpctl` should return valid output");
        let percent: f32 = percent.parse().expect("`wpctl` should return valid output");
        let mut percent = (100.0 * percent).round() as i32;

        let muted = output.peek().is_some();

        if muted {
            execute_wpctl(&["set-mute", self.low_level_name(), "0"]);
        }

        match action {
            Action::Up => percent += step,
            Action::Down => percent -= step,
            Action::Mute if !muted => {
                execute_wpctl(&["set-mute", self.low_level_name(), "1"]);
                return if notify {
                    Notification::new()
                        .summary(self.high_level_name())
                        .body("Muted")
                        .timeout(Milliseconds(400))
                        .hint(Custom(
                            String::from("x-canonical-private-synchronous"),
                            self.low_level_name().to_string(),
                        ))
                        .show()
                        .expect("notifications should work");
                };
            }
            _ => (),
        }

        percent = percent.clamp(0, max);
        let percent_formatted = format!("{percent}%");

        execute_wpctl(&["set-volume", self.low_level_name(), &percent_formatted]);

        if notify {
            Notification::new()
                .summary(self.high_level_name())
                .body(&percent_formatted)
                .hint(CustomInt(String::from("value"), percent))
                .hint(Custom(
                    String::from("x-canonical-private-synchronous"),
                    self.low_level_name().to_string(),
                ))
                .timeout(Milliseconds(400))
                .show()
                .expect("notifications should work");
        }
    }
}

fn cmd() -> clap::Command {
    command!()
        .arg(
            arg!(-o --sink <ACTION> "An action for the default sink")
                .value_parser(EnumValueParser::<Action>::new())
                .default_value("ignore")
                .hide_default_value(true),
        )
        .arg(
            arg!(-i --source <ACTION> "An action for the default source")
                .value_parser(EnumValueParser::<Action>::new())
                .default_value("ignore")
                .hide_default_value(true),
        )
        .arg(
            arg!(-s --step <PERCENT> "How much to change the volume, %")
                .value_parser(value_parser!(i32).range(0..=150))
                .default_value("1"),
        )
        .arg(
            arg!(-m --max <PERCENT> "A number to limit the volume up to, %")
                .value_parser(value_parser!(i32).range(100..))
                .default_value("100"),
        )
        .arg(
            arg!(-n --notify <FLAG> "Whether to show a notification")
                .value_parser(BoolishValueParser::new())
                .default_value("true")
                .hide_possible_values(true),
        )
        .arg_required_else_help(true)
}

fn main() {
    let matches = cmd().get_matches();

    let sink_action: &Action = matches
        .get_one("sink")
        .expect("at least, it has a default value");
    let source_action: &Action = matches
        .get_one("source")
        .expect("at least, it has a default value");
    let step: i32 = *matches
        .get_one("step")
        .expect("at least, it has a default value");
    let max: i32 = *matches
        .get_one("max")
        .expect("at least, it has a default value");
    let notify: bool = *matches
        .get_one("notify")
        .expect("at least, it has a default value");

    Device::DefaultAudioSink.apply(sink_action, step, max, notify);
    Device::DefaultAudioSource.apply(source_action, step, max, notify);
}

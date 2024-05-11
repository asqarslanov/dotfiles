use std::io;
use std::process::Command;

use notify_rust::{
    Hint::{Custom, CustomInt},
    Notification,
};

use crate::cli::UxArgs;
use crate::level_style::LevelStyle;

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
    pub fn apply(&self, args: &UxArgs) {
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
                .show()
                .expect("a notification daemon should work");
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
            .spawn()
            .expect("`brillo` and `pkexec` should work")
            .wait()
            .unwrap();
    }
}

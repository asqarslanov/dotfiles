use clap::{builder::PossibleValue, ValueEnum};

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

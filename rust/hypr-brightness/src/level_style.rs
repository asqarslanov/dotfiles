use clap::{builder::PossibleValue, ValueEnum};

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

use hypr_brightness::{cli::Args, direction::Direction, value::Value};

fn main() {
    let args = Args::build();
    let value = get_value(&args);
    value.apply(&args.ux)
}

fn get_value(args: &Args) -> Value {
    match args.logic.exact {
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
    }
}

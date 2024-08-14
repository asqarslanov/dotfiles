use std::path::PathBuf;

use clap::{arg, command, value_parser};

pub fn cmd() -> clap::Command {
    let default_config = dirs::config_dir()
        .expect("running as a Linux user, so the config dir should exist")
        .join("hypr/special-workspaces.toml")
        .into_os_string();

    command!()
        .arg(arg!([NAME] "The special workspace to launch").conflicts_with("all"))
        .arg(arg!(-a --all "Launch all non-lazy special workspaces"))
        .arg(
            arg!(-c --config <FILE> "Override the path to the config file")
                .default_value(default_config)
                .value_parser(value_parser!(PathBuf)),
        )
        .arg_required_else_help(true)
}

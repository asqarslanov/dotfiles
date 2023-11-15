/*
[package]
name = "toggle-special-workspace"
version = "2023.11.15"
edition = "2021"

[dependencies]
clap = { version = "4.4.8", features = ["cargo", "string"] }
dirs = "5.0.1"
hyprland = "0.3.12"
serde = "1.0.192"
serde_with = "3.4.0"
toml = "0.8.8"
*/

use clap::{arg, command, value_parser};
use hyprland::{
    data::Clients,
    dispatch::{Dispatch, DispatchType},
    keyword::Keyword,
    prelude::HyprData,
};
use serde::Deserialize;
use serde_with::{serde_as, DurationSeconds};
use std::collections::HashMap;
use std::fs;
use std::path::PathBuf;
use std::process::Command;
use std::thread;
use std::time::Duration;

#[serde_as]
#[derive(Deserialize, Default)]
#[serde(rename_all = "kebab-case")]
struct SpecialWorkspace {
    command: String,

    #[serde(default = "SpecialWorkspace::default_arguments")]
    arguments: Vec<String>,

    #[serde(rename = "launch-delay-seconds")]
    #[serde_as(as = "DurationSeconds<f64>")]
    #[serde(default = "SpecialWorkspace::default_launch_delay")]
    launch_delay: Duration,

    #[serde(default = "SpecialWorkspace::default_lazy")]
    lazy: bool,

    window_class: String,
}

impl SpecialWorkspace {
    fn default_arguments() -> Vec<String> {
        Vec::new()
    }

    fn default_launch_delay() -> Duration {
        Duration::from_secs_f64(2.5)
    }

    fn default_lazy() -> bool {
        true
    }

    fn presents(&self, name: &str) -> bool {
        let clients =
            Clients::get().expect("running inside a Hyprland session, so clients should exist");

        let name = format!("special:{name}");

        for client in clients {
            let class_matches = client.initial_class == self.window_class;
            let name_matches = client.workspace.name == name;

            if class_matches && name_matches {
                return true;
            }
        }

        false
    }

    fn launch(&self, name: &str, toggle: bool) {
        let window_class = format!("^({})$", self.window_class);

        if toggle {
            set_window_rule(&window_class, &format!("workspace special:{name}"));
        } else {
            set_window_rule(&window_class, &format!("workspace silent special:{name}"));
        }

        Command::new(&self.command)
            .args(&self.arguments)
            .spawn()
            .expect("the user should specify a valid command");

        thread::sleep(self.launch_delay);

        set_window_rule(&window_class, "workspace unset");
    }

    fn toggle_special_workspace(name: &str) {
        let name = Some(String::from(name));
        let dispatch = DispatchType::ToggleSpecialWorkspace(name);
        Dispatch::call(dispatch).expect("the special workspace was created previously");
    }
}

fn set_window_rule(window_class: &str, window_rule: &str) {
    let rule = format!("{window_rule}, {window_class}");
    Keyword::set("windowrule", rule).expect("the window rule should be applied successfully");
}

fn cmd() -> clap::Command {
    let default_config = dirs::config_dir()
        .expect("running as a Linux user, so the config dir should exist")
        .join("hypr/special-workspaces.toml")
        .into_os_string();

    command!()
        .arg(arg!([NAME] "The special workspace to launch").required_unless_present("all"))
        .arg(arg!(-a --all "Launch all non-lazy special workspaces"))
        .arg(
            arg!(-c --config <FILE> "Override the path to the config file")
                .default_value(default_config)
                .value_parser(value_parser!(PathBuf)),
        )
        .arg_required_else_help(true)
}

fn main() {
    let matches = cmd().get_matches();

    let config: &PathBuf = matches
        .get_one("config")
        .expect("the config file path is set by default");

    let special_workspaces =
        fs::read_to_string(config).expect("the file should exist and be readable");

    let special_workspaces: HashMap<String, SpecialWorkspace> =
        toml::from_str(&special_workspaces).expect("the file's structure should be correct");

    let all = matches.get_flag("all");
    if all {
        return for (name, special_workspace) in special_workspaces {
            if !special_workspace.lazy && !special_workspace.presents(&name) {
                special_workspace.launch(&name, false);
            }
        };
    }

    let name: &String = matches
        .get_one("NAME")
        .expect("the special workspace name is required at this point");

    let special_workspace = &special_workspaces[name];

    if !special_workspace.presents(name) {
        return special_workspace.launch(name, true);
    }

    SpecialWorkspace::toggle_special_workspace(name);
}

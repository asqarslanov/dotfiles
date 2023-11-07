/*
[package]
name = "toggle-special-workspace"
version = "2023.11.7"
edition = "2021"

[dependencies]
clap = { version = "4.4.7", features = ["derive", "string"] }
dirs = "5.0.1"
hyprland = "0.3.12"
serde = { version = "1.0.192", features = ["derive"] }
serde_with = "3.4.0"
toml = "0.8.8"
*/

use clap::Parser;
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

#[derive(Parser)]
#[command(version)]
struct CommandLineArguments {
    special_workspace: String,
    #[arg(short, long)]
    all: bool,
    #[arg(short, long, default_value = CommandLineArguments::default_source().into_os_string())]
    #[arg(short, long)]
    source: PathBuf,
}

impl CommandLineArguments {
    fn default_source() -> PathBuf {
        dirs::config_dir()
            .expect("The config dir to exist")
            .join("hypr")
            .join("special-workspaces.toml")
    }
}

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
        vec![]
    }

    fn default_launch_delay() -> Duration {
        Duration::from_secs_f64(2.5)
    }

    fn default_lazy() -> bool {
        true
    }

    fn presents(&self, name: &str) -> bool {
        for client in Clients::get().expect("Running inside a Hyprland session") {
            if client.initial_class == self.window_class
                && client.workspace.name == format!("special:{name}")
            {
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
            .expect("The user to write a working command");

        thread::sleep(self.launch_delay);

        set_window_rule(&window_class, "workspace unset");
    }

    fn toggle_special_workspace(name: &str) {
        let name = Some(String::from(name));
        let dispatch = DispatchType::ToggleSpecialWorkspace(name);
        Dispatch::call(dispatch).expect("The special workspace to exist");
    }
}

fn set_window_rule(window_class: &str, window_rule: &str) {
    let rule = format!("{window_rule}, {window_class}");
    Keyword::set("windowrule", rule).expect("The rule to be applied successfully");
}

fn main() {
    let arguments = CommandLineArguments::parse();

    let special_workspaces = fs::read_to_string(arguments.source).expect("The file to be readable");

    let special_workspaces: HashMap<String, SpecialWorkspace> =
        toml::from_str(&special_workspaces).expect("The file's structure to be correct");

    if arguments.all {
        return for (name, special_workspace) in special_workspaces {
            if !special_workspace.lazy && !special_workspace.presents(&name) {
                special_workspace.launch(&name, false);
            }
        };
    }

    let special_workspace = &special_workspaces[&arguments.special_workspace];

    if !special_workspace.presents(&arguments.special_workspace) {
        return special_workspace.launch(&arguments.special_workspace, true);
    }

    SpecialWorkspace::toggle_special_workspace(&arguments.special_workspace);
}

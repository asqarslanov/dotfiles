use std::collections::HashMap;
use std::env;
use std::fs;

fn main() {
    let special_workspaces = dirs::config_dir()
        .unwrap()
        .join("hypr")
        .join("special-workspaces.toml");

    let special_workspaces = fs::read_to_string(special_workspaces).unwrap();
    let special_workspaces: HashMap<String, SpecialWorkspace> =
        toml::from_str(&special_workspaces).unwrap();

    let argument = {
        let arguments = env::args().skip(1);
        assert_eq!(arguments.len(), 1);

        arguments.last().unwrap()
    };
    let launch_all = ["-a", "--all"].into_iter().any(|e| e == argument);

    if launch_all {
        return for (name, special_workspace) in special_workspaces {
            if !special_workspace.lazy && !special_workspace.is_running(&name) {
                special_workspace.launch(&name, false);
            }
        };
    }

    let name = argument;
    let special_workspace = &special_workspaces[&name];

    if !special_workspace.is_running(&name) {
        special_workspace.launch(&name, true);
    } else {
        toggle_special_workspace(&name);
    }
}

use hyprland::{
    data::Clients,
    dispatch::{Dispatch, DispatchType},
    keyword::Keyword,
    prelude::HyprData,
};
use serde::Deserialize;
use std::process::Command;
use std::thread;
use std::time::Duration;

#[derive(Deserialize)]
struct SpecialWorkspace {
    command: String,
    launch_delay: f32,
    lazy: bool,
    window_class: String,
    window_rules: Vec<String>,
}

impl SpecialWorkspace {
    fn is_running(&self, name: &str) -> bool {
        for client in Clients::get().unwrap() {
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

        set_window_rule(&format!("workspace special:{name}"), &window_class);
        for window_rule in &self.window_rules {
            set_window_rule(window_rule, &window_class);
        }

        let (command, arguments) = {
            let mut command = self.command.split_ascii_whitespace();
            (command.next().unwrap(), command)
        };
        Command::new(command).args(arguments).spawn().unwrap();

        let launch_delay = Duration::from_secs_f32(self.launch_delay);
        thread::sleep(launch_delay);

        set_window_rule("unset", &window_class);

        if toggle {
            toggle_special_workspace(name);
        }
    }
}

fn toggle_special_workspace(name: &str) {
    let name = Some(String::from(name));
    let dispatch = DispatchType::ToggleSpecialWorkspace(name);

    Dispatch::call(dispatch).unwrap();
}

fn set_window_rule(window_rule: &str, window_class: &str) {
    let rule = format!("{window_rule}, {window_class}");

    Keyword::set("windowrule", rule).unwrap();
}

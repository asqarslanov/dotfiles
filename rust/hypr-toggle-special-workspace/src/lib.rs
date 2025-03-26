use hyprland::{
    data::Clients,
    dispatch::{Dispatch, DispatchType},
    keyword::Keyword,
    prelude::HyprData,
};
use serde::Deserialize;
use serde_with::{DurationSeconds, serde_as};
use std::process::Command;
use std::thread;
use std::time::Duration;

pub mod cli;

#[serde_as]
#[derive(Deserialize, Default)]
#[serde(rename_all = "kebab-case")]
pub struct SpecialWorkspace {
    command: String,

    #[serde(default = "SpecialWorkspace::default_arguments")]
    arguments: Vec<String>,

    #[serde(rename = "launch-delay-seconds")]
    #[serde_as(as = "DurationSeconds<f64>")]
    #[serde(default = "SpecialWorkspace::default_launch_delay")]
    launch_delay: Duration,

    #[serde(default = "SpecialWorkspace::default_lazy")]
    pub lazy: bool,

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

    pub fn presents(&self, name: &str) -> bool {
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

    pub fn launch(&self, name: &str, toggle: bool) {
        if toggle {
            set_window_rule(&self.window_class, &format!("workspace special:{name}"));
        } else {
            set_window_rule(
                &self.window_class,
                &format!("workspace special:{name} silent"),
            );
        }

        Command::new(&self.command)
            .args(&self.arguments)
            .spawn()
            .expect("the user should specify a valid command");

        thread::sleep(self.launch_delay);

        set_window_rule(&self.window_class, "workspace unset");
    }

    pub fn toggle_special_workspace(name: &str) {
        let name = Some(String::from(name));
        let dispatch = DispatchType::ToggleSpecialWorkspace(name);
        Dispatch::call(dispatch).expect("the special workspace was created previously");
    }
}

pub fn set_window_rule(window_class: &str, window_rule: &str) {
    let window_class = format!("^{}$", regex::escape(window_class));
    let rule = format!("{window_rule}, class:{window_class}");

    Keyword::set("windowrule", rule).expect("the window rule should be applied successfully");
}

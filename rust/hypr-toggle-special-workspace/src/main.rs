use std::collections::HashMap;
use std::fs;
use std::path::PathBuf;

use hypr_toggle_special_workspace::{SpecialWorkspace, cli};

fn main() -> eyre::Result<()> {
    color_eyre::install()?;

    let matches = cli::cmd().get_matches();

    let config: &PathBuf = matches
        .get_one("config")
        .expect("the config file path is set by default");

    let special_workspaces =
        fs::read_to_string(config).expect("the file should exist and be readable");

    let special_workspaces: HashMap<String, SpecialWorkspace> =
        toml::from_str(&special_workspaces).expect("the file's structure should be correct");

    let all = matches.get_flag("all");
    if all {
        for (name, special_workspace) in special_workspaces {
            if !special_workspace.lazy && !special_workspace.presents(&name) {
                special_workspace.launch(&name, false);
            }
        }
        return Ok(());
    }

    let name: &String = matches
        .get_one("NAME")
        .expect("the special workspace name is required at this point");

    let special_workspace = &special_workspaces[name];

    if !special_workspace.presents(name) {
        special_workspace.launch(name, true);
        return Ok(());
    }

    SpecialWorkspace::toggle_special_workspace(name);
    Ok(())
}

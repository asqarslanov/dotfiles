/*
[package]
name = "workspaces"
version = "2023.11.15"
edition = "2021"

[dependencies]
hyprland = "0.3.12"
serde = "1.0.192"
serde_json = "1.0.108"
*/

use hyprland::{data::Workspaces, prelude::HyprData, shared::WorkspaceId};
use serde::Serialize;

#[derive(Serialize)]
struct WorkspaceProcessed {
    id: WorkspaceId,
    name: String,
    occupation: Occupation,
}

impl WorkspaceProcessed {
    fn with_id_and_name(id: WorkspaceId, name: &str) -> Self {
        Self {
            id,
            name: name.to_string(),
            occupation: Occupation::Empty,
        }
    }
}

#[derive(Serialize)]
#[serde(rename_all = "lowercase")]
enum Occupation {
    Empty,
    Occupied,
    HasFullscreen,
}

fn main() {
    let mut workspaces_processed = [
        WorkspaceProcessed::with_id_and_name(1, "1"),
        WorkspaceProcessed::with_id_and_name(2, "2"),
        WorkspaceProcessed::with_id_and_name(3, "3"),
        WorkspaceProcessed::with_id_and_name(4, "4"),
        WorkspaceProcessed::with_id_and_name(5, "5"),
        WorkspaceProcessed::with_id_and_name(6, "6"),
        WorkspaceProcessed::with_id_and_name(7, "7"),
        WorkspaceProcessed::with_id_and_name(8, "8"),
        WorkspaceProcessed::with_id_and_name(9, "9"),
        WorkspaceProcessed::with_id_and_name(10, "0"),
    ];

    for workspace in
        Workspaces::get().expect("running inside a Hyprland session, so workspaces exist")
    {
        let id = workspace.id;

        if !(1..=10).contains(&id) {
            continue;
        }

        let id = usize::try_from(id - 1).expect("the workspace IDs are hardcoded to be valid");

        if workspace.fullscreen {
            workspaces_processed[id].occupation = Occupation::HasFullscreen;
        } else if workspace.windows > 0 {
            workspaces_processed[id].occupation = Occupation::Occupied;
        }
    }

    let workspaces_processed =
        serde_json::to_string(&workspaces_processed).expect("the structure should be serializable");
    println!("{workspaces_processed}");
}

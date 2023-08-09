use hyprland::{data::Workspaces, prelude::HyprData};

fn main() {
    let mut workspaces_processed = [
        WorkspaceProcessed::build(1, "1"),
        WorkspaceProcessed::build(2, "2"),
        WorkspaceProcessed::build(3, "3"),
        WorkspaceProcessed::build(4, "4"),
        WorkspaceProcessed::build(5, "5"),
        WorkspaceProcessed::build(6, "6"),
        WorkspaceProcessed::build(7, "7"),
        WorkspaceProcessed::build(8, "8"),
        WorkspaceProcessed::build(9, "9"),
        WorkspaceProcessed::build(10, "0"),
    ];

    for workspace in Workspaces::get().unwrap() {
        let id = workspace.id;

        if !(1..=10).contains(&id) {
            continue;
        }

        let id = usize::try_from(id - 1).unwrap();

        if workspace.fullscreen {
            workspaces_processed[id].occupation = Occupation::HasFullscreen;
        } else if workspace.windows > 0 {
            workspaces_processed[id].occupation = Occupation::Occupied;
        }
    }

    let workspaces_processed = serde_json::to_string(&workspaces_processed).unwrap();
    println!("{workspaces_processed}");
}

use hyprland::shared::WorkspaceId;
use serde::Serialize;

#[derive(Serialize)]
struct WorkspaceProcessed {
    id: WorkspaceId,
    name: String,
    occupation: Occupation,
}

impl WorkspaceProcessed {
    fn build(id: WorkspaceId, name: &str) -> Self {
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

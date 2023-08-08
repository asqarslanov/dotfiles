fn main() {
    let mut workspaces = [
        build_workspace(1, 1),
        build_workspace(2, 2),
        build_workspace(3, 3),
        build_workspace(4, 4),
        build_workspace(5, 5),
        build_workspace(6, 6),
        build_workspace(7, 7),
        build_workspace(8, 8),
        build_workspace(9, 9),
        build_workspace(10, 0),
    ];

    let all_workspaces = Command::new("hyprctl")
        .args(["-j", "workspaces"])
        .output()
        .unwrap()
        .stdout;

    let all_workspaces = unsafe { &String::from_utf8_unchecked(all_workspaces) };
    let all_workspaces: Value = serde_json::from_str(all_workspaces).unwrap();

    for workspace in all_workspaces.as_array().unwrap() {
        let id = workspace["id"].as_i64().unwrap();

        if !(1..=10).contains(&id) {
            continue;
        }

        let id = usize::try_from(id - 1).unwrap();

        if workspace["hasfullscreen"].as_bool().unwrap() {
            workspaces[id].occupation = Occupation::HasFullscreen;
        } else if workspace["windows"].as_u64().unwrap() > 0 {
            workspaces[id].occupation = Occupation::Occupied;
        }
    }

    println!("{}", serde_json::to_string(&workspaces).unwrap());
}

use serde::{ser::SerializeStruct, Serialize, Serializer};
use serde_json::Value;
use std::process::Command;

struct Workspace {
    id: u8,
    name: u8,
    occupation: Occupation,
}

impl Serialize for Workspace {
    fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: Serializer,
    {
        let mut state = serializer.serialize_struct("Workspace", 4)?;

        state.serialize_field("id", &self.id)?;
        state.serialize_field("name", &self.name)?;
        state.serialize_field("occupation", &self.occupation)?;

        state.end()
    }
}

fn build_workspace(id: u8, name: u8) -> Workspace {
    Workspace {
        id,
        name,
        occupation: Occupation::Empty,
    }
}

enum Occupation {
    Empty,
    Occupied,
    HasFullscreen,
}

impl Serialize for Occupation {
    fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: Serializer,
    {
        match *self {
            Occupation::Empty => serializer.serialize_unit_variant("Occupation", 0, "empty"),
            Occupation::Occupied => serializer.serialize_unit_variant("Occupation", 1, "occupied"),
            Occupation::HasFullscreen => {
                serializer.serialize_unit_variant("Occupation", 2, "hasfullscreen")
            }
        }
    }
}

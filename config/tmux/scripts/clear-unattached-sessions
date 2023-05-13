#!/usr/bin/env python3

import subprocess


def get_command_output(command: str) -> str:
    arguments = command.split()
    process = subprocess.run(arguments, capture_output=True, text=True)

    result: str = process.stdout

    return result


def get_session_name(session: str) -> str:
    colon_index = session.find(":")
    name = session[:colon_index]

    return name


if __name__ == "__main__":
    sessions = get_command_output("tmux list-sessions")
    sessions = sessions.split("\n")
    sessions.pop()

    for session in sessions:
        if session.endswith("(attached)"):
            continue

        name = get_session_name(session)

        if not name.startswith("!"):
            subprocess.run(("tmux", "kill-session", "-t", name))

#!/usr/bin/env python3

import subprocess
import time


def get_command_output(command: str) -> str:
    arguments = command.split()
    process = subprocess.run(arguments, capture_output=True, text=True)

    result: str = process.stdout

    return result


def get_current_time() -> str:
    TIME_FORMAT = "%Y-%m-%d-%H-%M-%S-%N"
    current_time = time.strftime(TIME_FORMAT)

    nanoseconds = time.time_ns()
    nanoseconds %= int(1e9)
    nanoseconds = str(nanoseconds)
    nanoseconds = nanoseconds.rjust(9, "0")

    current_time = current_time.replace("%N", nanoseconds)

    return current_time


def get_session_name(session: str) -> str:
    colon_index = session.find(":")
    name = session[:colon_index]

    return name


if __name__ == "__main__":
    sessions = get_command_output("tmux list-sessions")
    sessions = sessions.split("\n")

    new_name = get_current_time()

    if sessions[0].startswith("!"):
        name = get_session_name(sessions[0])
        subprocess.run(("tmux", "rename-session", "-t", name, new_name))
        subprocess.run(("tmux", "attach", "-t", new_name))

    else:
        new_name = get_current_time()
        subprocess.run(("tmux", "new-session", "-s", new_name))

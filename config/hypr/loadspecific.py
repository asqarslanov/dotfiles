#!/usr/bin/env python3

import os
import socket

hostname = socket.gethostname()
username = os.getlogin()


base_dir = f"/home/{username}/.config/hypr"

host_specific_dir = f"{base_dir}/host-specific"
user_specific_dir = f"{base_dir}/user-specific"


output = "# This file is written by load_specific.py. Do not edit.\n"

if hostname + ".conf" in os.listdir(host_specific_dir):
    output += "\n"
    output += f"source = {host_specific_dir}/{hostname}.conf"
    output += "\n"

if username + ".conf" in os.listdir(user_specific_dir):
    output += "\n"
    output += f"source = {user_specific_dir}/{username}.conf"
    output += "\n"


with open(f"{base_dir}/loadspecific.conf", "w") as output_file:
    output_file.write(output)

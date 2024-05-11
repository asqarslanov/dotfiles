#!/usr/bin/env sh

socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
  while read -r line; do
    ~/.config/eww/bin/workspaces
  done

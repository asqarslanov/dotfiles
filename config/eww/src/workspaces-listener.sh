#!/usr/bin/env sh

handle() {
  case $1 in
  workspace*) ~/.config/eww/bin/workspaces ;;
  fullscreen*) ~/.config/eww/bin/workspaces ;;
  openwindow*) ~/.config/eww/bin/workspaces ;;
  closewindow*) ~/.config/eww/bin/workspaces ;;
  movewindow*) ~/.config/eww/bin/workspaces ;;
  esac
}

socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock |
  while read -r line; do
    handle "$line"
  done
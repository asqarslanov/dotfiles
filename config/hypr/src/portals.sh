#!/usr/bin/env sh

delay=$1

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

sleep $delay

killall --exact xdg-desktop-portal-hyprland
killall --exact xdg-desktop-portal-gtk
killall --exact xdg-desktop-portal

/usr/lib/xdg-desktop-portal-hyprland &

sleep $delay

/usr/lib/xdg-desktop-portal-gtk &

sleep $delay

/usr/lib/xdg-desktop-portal &

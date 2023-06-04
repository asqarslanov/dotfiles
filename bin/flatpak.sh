#!/usr/bin/env bash

sudo flatpak override --env=CLUTTER_BACKEND=$CLUTTER_BACKEND
sudo flatpak override --env=GDK_BACKEND=$GDK_BACKEND
sudo flatpak override --env=GTK_THEME=$GTK_THEME
sudo flatpak override --env=ICON_THEME=$ICON_THEME
sudo flatpak override --env=QT_AUTO_SCREEN_SCALE_FACTOR=$QT_AUTO_SCREEN_SCALE_FACTOR
sudo flatpak override --env=QT_QPA_PLATFORM=$QT_QPA_PLATFORM
sudo flatpak override --env=QT_QPA_PLATFORMTHEME=$QT_QPA_PLATFORMTHEME
sudo flatpak override --env=QT_WAYLAND_DISABLE_WINDOWDECORATION=$QT_WAYLAND_DISABLE_WINDOWDECORATION
sudo flatpak override --env=SDL_VIDEODRIVER=$SDL_VIDEODRIVER
sudo flatpak override --env=XDG_SESSION_DESKTOP=$XDG_SESSION_DESKTOP

sudo flatpak override --filesystem=/usr/share/themes:ro
sudo flatpak override --filesystem=/usr/share/icons:ro

sudo flatpak override --filesystem=host:ro com.discordapp.Discord
sudo flatpak override --filesystem=host:ro com.google.Chrome
sudo flatpak override --filesystem=host:ro org.telegram.desktop
sudo flatpak override --filesystem=xdg-download org.telegram.desktop

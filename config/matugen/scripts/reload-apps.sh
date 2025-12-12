#!/bin/bash

# Parallel reload script for all apps after matugen generates colors
# All reloads run simultaneously for instant color sync

# Run all reloads in parallel using background processes
{
    # GTK theme reload
    gsettings set org.gnome.desktop.interface gtk-theme "" 
    gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
} &

# Kitty terminal
kitty +kitten themes --reload-in=all Matugen &

# Hyprland
hyprctl reload &

# Waybar
~/.config/waybar/scripts/launch-waybar.sh &

# Mako notifications
makoctl reload &

# Signal-based reloads (these are instant)
pkill -SIGUSR1 rofi 2>/dev/null &
pkill -USR1 cava 2>/dev/null &
pkill -SIGUSR2 btop 2>/dev/null &
pkill -SIGUSR1 nvim 2>/dev/null &
pkill -SIGUSR2 yazi 2>/dev/null &
pkill -SIGUSR1 foot 2>/dev/null &

# tty-clock wrapper permissions
chmod +x ~/.local/bin/tty-clock-themed 2>/dev/null &

# Wait for all background jobs to complete
wait

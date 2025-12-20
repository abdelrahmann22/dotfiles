#!/usr/bin/env bash
set -euo pipefail

# Prevent overlapping reloads (e.g. multiple wallpaper changes quickly)
LOCK_FILE="/tmp/matugen-reload-apps.lock"
exec 9>"$LOCK_FILE"
flock -n 9 || exit 0

# Parallel reload script for all apps after matugen generates colors
# All reloads run simultaneously for instant color sync

# Run all reloads in parallel using background processes
if command -v gsettings >/dev/null 2>&1; then
{
        # GTK theme reload (forces GTK apps to pick up new colors)
    gsettings set org.gnome.desktop.interface gtk-theme "" 
    gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
} &
fi

# Kitty terminal
kitty +kitten themes --reload-in=all Matugen &

# Hyprland - no reload needed, it watches colors.conf automatically
# hyprctl reload &

# Waybar
# Your waybar already has "reload_style_on_change": true, and matugen only updates style.css.
# Avoid restarting waybar here (cheaper + avoids flicker/duplicate-race); kanshi will restart it
# when outputs change anyway.
# (no-op)

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

# Don't wait - let background jobs complete asynchronously for faster response

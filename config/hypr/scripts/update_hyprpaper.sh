#!/bin/bash

# Script to update hyprpaper.conf when wallpaper is changed via waypaper
# Usage: update_hyprpaper.sh <wallpaper_path>

WALLPAPER_PATH="$1"
HYPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

if [ -z "$WALLPAPER_PATH" ]; then
    echo "Error: No wallpaper path provided"
    exit 1
fi

# Convert absolute path to ~ format if it's in home directory
if [[ "$WALLPAPER_PATH" == "$HOME"/* ]]; then
    WALLPAPER_PATH="${WALLPAPER_PATH/#$HOME/\~}"
fi

# Update hyprpaper.conf
if [ -f "$HYPAPER_CONF" ]; then
    # Update preload line
    sed -i "s|^preload = .*|preload = $WALLPAPER_PATH|" "$HYPAPER_CONF"
    
    # Update wallpaper line (format: wallpaper = ,<path>)
    sed -i "s|^wallpaper = ,.*|wallpaper = ,$WALLPAPER_PATH|" "$HYPAPER_CONF"
    
    # Reload hyprpaper to apply the new wallpaper
    hyprctl hyprpaper reload
else
    echo "Warning: hyprpaper.conf not found at $HYPAPER_CONF"
fi

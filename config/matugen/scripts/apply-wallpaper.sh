#!/bin/bash

# Wallpaper application script with parallel app reloads
# Usage: apply-wallpaper.sh <wallpaper_path>

WALLPAPER_PATH="$1"
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

if [ -z "$WALLPAPER_PATH" ]; then
    echo "Error: No wallpaper path provided"
    exit 1
fi

# Run matugen to generate colors (no post_hooks, just template generation)
matugen image "$WALLPAPER_PATH"

# Now reload all apps in parallel
"$SCRIPT_DIR/reload-apps.sh"

# Update hyprpaper config if needed
if [ -f "$HOME/.config/hypr/scripts/update_hyprpaper.sh" ]; then
    "$HOME/.config/hypr/scripts/update_hyprpaper.sh" "$WALLPAPER_PATH" &
fi

wait

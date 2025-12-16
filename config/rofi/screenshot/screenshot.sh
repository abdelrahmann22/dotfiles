#!/usr/bin/env bash

dir="$HOME/.config/rofi/screenshot"
theme='screenshot-gnome'

# Screenshot options with clean GNOME-style text
options="󰍹
󰖯
󱣴"

# Show menu with GNOME-style theme
selected=$(echo "$options" | rofi -dmenu -i -mesg "Take a Screenshot" -theme ${dir}/${theme}.rasi -format 's')

# Execute screenshot based on selection - all open with satty for annotation
if [ -n "$selected" ]; then
    case "$selected" in
        "󰍹")
            ~/.config/hypr/scripts/screenshot-annotate.sh output
            ;;
        "󰖯")
            ~/.config/hypr/scripts/screenshot-annotate.sh window
            ;;
        "󱣴")
            ~/.config/hypr/scripts/screenshot-annotate.sh region
            ;;
    esac
fi

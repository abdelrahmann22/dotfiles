#!/usr/bin/env bash

dir="$HOME/.config/rofi"
theme='screenshot-gnome'
quality_wrapper="$HOME/.config/rofi/screenshot/hyprshot-quality.sh"

# Screenshot options with clean GNOME-style text
options="󰍹
󰖯
󱣴"

# Show menu with GNOME-style theme
selected=$(echo "$options" | rofi -dmenu -i -mesg "Take a Screenshot" -theme ${dir}/${theme}.rasi -format 's')

# Execute screenshot based on selection with maximum quality
if [ -n "$selected" ]; then
    case "$selected" in
        "󰍹")
            "$quality_wrapper" output
            ;;
        "󰖯")
            "$quality_wrapper" window
            ;;
        "󱣴")
            "$quality_wrapper" region
            ;;
    esac
fi

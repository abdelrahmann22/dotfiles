#!/usr/bin/env bash

dir="$HOME/.config/rofi/window"
theme='window-style'

# Count open windows and calculate dynamic width
# Each element is ~120px wide (100px + spacing + padding)
element_width=106
padding=48  # 24px padding on each side

# Get number of windows (using hyprctl for Hyprland)
if command -v hyprctl &> /dev/null; then
    window_count=$(hyprctl clients -j | jq 'length')
else
    # Fallback: use wmctrl
    window_count=$(wmctrl -l 2>/dev/null | wc -l)
fi

# Ensure at least 1 window
[ "$window_count" -lt 1 ] && window_count=1
# Cap at 10 windows max width
[ "$window_count" -gt 10 ] && window_count=10

# Calculate width
width=$((window_count * element_width + padding))

## Run
rofi \
    -show window \
    -theme ${dir}/${theme}.rasi \
    -theme-str "window { width: ${width}px; }"

#!/bin/bash

# TTY-Clock color configuration
# This script sets the terminal colors that tty-clock will use

# Extract RGB values from hex colors
PRIMARY_COLOR="{{colors.primary.default.hex_stripped}}"
SECONDARY_COLOR="{{colors.secondary.default.hex_stripped}}"

# Convert hex to RGB
hex_to_rgb() {
    hex=$1
    r=$((16#${hex:0:2}))
    g=$((16#${hex:2:2}))
    b=$((16#${hex:4:2}))
    echo "$r;$g;$b"
}

PRIMARY_RGB=$(hex_to_rgb "$PRIMARY_COLOR")
SECONDARY_RGB=$(hex_to_rgb "$SECONDARY_COLOR")

# Export colors for tty-clock (using ANSI escape codes)
export TTY_CLOCK_COLOR="\033[38;2;${PRIMARY_RGB}m"
export TTY_CLOCK_RESET="\033[0m"

# Run tty-clock with color support
# tty-clock -c -C $(echo "$PRIMARY_COLOR" | sed 's/#//')


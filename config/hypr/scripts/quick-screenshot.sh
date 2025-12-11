#!/usr/bin/env bash

# Quick screenshot without rofi menu
OUTPUT_DIR="${HOME}/Pictures/Screenshots"
mkdir -p "$OUTPUT_DIR"
FILENAME="screenshot-$(date +'%Y%m%d-%H%M%S').png"
FILEPATH="${OUTPUT_DIR}/${FILENAME}"

# Capture selected region
GEOMETRY=$(slurp)
if [ -n "$GEOMETRY" ]; then
    grim -t png -l 3 -g "$GEOMETRY" "$FILEPATH"
    wl-copy < "$FILEPATH"
    notify-send -t 3000 "Screenshot" "Region captured\n$FILENAME"
fi

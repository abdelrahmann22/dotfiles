#!/usr/bin/env bash

# Custom hyprshot wrapper with maximum quality settings
# PNG compression level: 0 = no compression (fastest, largest files, no quality loss)
# PNG compression level: 9 = max compression (slowest, smallest files, no quality loss)
# We use level 0-3 for best quality/performance balance

MODE="$1"
OUTPUT_DIR="${HOME}/Pictures/Screenshots"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Generate filename with timestamp
FILENAME="screenshot-$(date +'%Y%m%d-%H%M%S').png"
FILEPATH="${OUTPUT_DIR}/${FILENAME}"

case "$MODE" in
    "output")
        # Capture entire monitor with minimal compression
        GEOMETRY=$(slurp -or)
        if [ -n "$GEOMETRY" ]; then
            grim -t png -l 3 -g "$GEOMETRY" "$FILEPATH"
            wl-copy < "$FILEPATH"
            notify-send -t 3000 "Screenshot" "Monitor captured\n$FILENAME"
        fi
        ;;
    "window")
        # Capture selected window with minimal compression
        # Use slurp to select window interactively
        GEOMETRY=$(slurp -f '%x,%y %wx%h')
        if [ -n "$GEOMETRY" ]; then
            grim -t png -l 3 -g "$GEOMETRY" "$FILEPATH"
            wl-copy < "$FILEPATH"
            notify-send -t 3000 "Screenshot" "Window captured\n$FILENAME"
        fi
        ;;
    "region")
        # Capture selected region with minimal compression
        GEOMETRY=$(slurp)
        if [ -n "$GEOMETRY" ]; then
            grim -t png -l 3 -g "$GEOMETRY" "$FILEPATH"
            wl-copy < "$FILEPATH"
            notify-send -t 3000 "Screenshot" "Region captured\n$FILENAME"
        fi
        ;;
esac

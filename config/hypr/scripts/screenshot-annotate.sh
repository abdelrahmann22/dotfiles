#!/usr/bin/env bash

# Screenshot modes: output, window, region
MODE="${1:-region}"

# Output directory
OUTPUT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$OUTPUT_DIR"

# Get timestamp before screenshot
BEFORE=$(date +%s)

# Take screenshot with hyprshot
hyprshot -m "$MODE" -o "$OUTPUT_DIR" -f Screenshot_$(date '+%Y%m%d_%H%M%S').png

# Wait a moment for file to be written
sleep 0.2

# Find the screenshot file that was just created (newest file after our timestamp)
SCREENSHOT_FILE=$(find "$OUTPUT_DIR" -type f -name "Screenshot_*.png" -newermt "@$BEFORE" -printf '%T@ %p\n' 2>/dev/null | sort -rn | head -1 | cut -d' ' -f2-)

# Open satty for annotation if screenshot was taken
if [ -n "$SCREENSHOT_FILE" ] && [ -f "$SCREENSHOT_FILE" ]; then
    # Use the same filename for satty output (it will replace the original)
    # Open satty with the screenshot (floating window)
    satty --filename "$SCREENSHOT_FILE" --output-filename "$SCREENSHOT_FILE"
else
    notify-send "Screenshot" "Failed to capture screenshot" -u critical
fi

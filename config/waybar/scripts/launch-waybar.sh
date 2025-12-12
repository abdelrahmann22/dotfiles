#!/bin/bash

# Kill any existing waybar instances
killall waybar 2>/dev/null

# Brief wait for process to terminate (non-blocking approach)
sleep 0.1

CONFIG_DIR="$HOME/.config/waybar"
TEMP_CONFIG="/tmp/waybar-config.jsonc"

# Check if HDMI-A-1 is connected
if hyprctl monitors | grep -q "HDMI-A-1"; then
    # HDMI-A-1 is connected (dual screen mode) - add output field for HDMI-A-1
    OUTPUT="HDMI-A-1"
else
    # Only eDP-1 is connected (single screen mode) - add output field for eDP-1
    OUTPUT="eDP-1"
fi

# Create temporary config with the appropriate output field
sed "2a\  \"output\": \"$OUTPUT\"," "$CONFIG_DIR/config.jsonc" > "$TEMP_CONFIG"

# Launch waybar with the temporary config (config is read immediately, so we can clean up quickly)
waybar --config "$TEMP_CONFIG" --style "$CONFIG_DIR/style.css" --log-level error &

# Clean up temp config in background after waybar has loaded
(sleep 0.5 && rm -f "$TEMP_CONFIG") &


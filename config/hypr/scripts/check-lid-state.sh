#!/usr/bin/env bash
set -euo pipefail

# Wait for kanshi to start
sleep 1

# Check if HDMI-A-1 is connected
if ! hyprctl monitors | grep -q "HDMI-A-1"; then
    # Only laptop screen, no need to check lid
    exit 0
fi

# Check lid state from /proc/acpi/button/lid/LID0/state or similar
LID_STATE=""
for lid_path in /proc/acpi/button/lid/*/state; do
    if [ -f "$lid_path" ]; then
        LID_STATE=$(cat "$lid_path" | awk '{print $2}')
        break
    fi
done

# If lid is closed and HDMI is connected, switch to lid-closed profile
if [ "$LID_STATE" = "closed" ]; then
    kanshictl switch lid-closed
else
    kanshictl switch dual-monitor
fi

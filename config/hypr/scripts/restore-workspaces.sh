#!/usr/bin/env bash
set -euo pipefail

# Wait a moment for monitors to be detected
sleep 0.5

# Get monitors data once
MONITORS_JSON=$(hyprctl monitors -j 2>/dev/null || echo '[]')

# Check if monitors are available
HDMI_CONNECTED=$(
    echo "$MONITORS_JSON" \
        | jq -r '.[] | select(.name=="HDMI-A-1" and (.disabled|not)) | .name' \
        | head -n1 \
        || echo ""
)
EDP_CONNECTED=$(
    echo "$MONITORS_JSON" \
        | jq -r '.[] | select(.name=="eDP-1" and (.disabled|not)) | .name' \
        | head -n1 \
        || echo ""
)

# Only proceed if both monitors are connected (dual-monitor setup)
if [ -n "$HDMI_CONNECTED" ] && [ -n "$EDP_CONNECTED" ]; then
    # Remember current workspace to restore focus after moving
    CURRENT_WS=$(hyprctl activeworkspace -j 2>/dev/null | jq -r '.id' || echo "1")
    
    # Get workspaces data once
    WS_JSON=$(hyprctl workspaces -j 2>/dev/null || echo '[]')
    
    # Move workspaces 1-4 to HDMI-A-1 only if they're not already there
    for ws in 1 2 3 4; do
        WS_MONITOR=$(echo "$WS_JSON" | jq -r ".[] | select(.id==$ws) | .monitor" || echo "")
        if [ -n "$WS_MONITOR" ] && [ "$WS_MONITOR" != "HDMI-A-1" ]; then
            hyprctl dispatch moveworkspacetomonitor "$ws" HDMI-A-1 2>/dev/null || true
        fi
    done
    
    # Move workspace 5 to eDP-1 only if it's not already there
    WS5_MONITOR=$(echo "$WS_JSON" | jq -r '.[] | select(.id==5) | .monitor' || echo "")
    if [ -n "$WS5_MONITOR" ] && [ "$WS5_MONITOR" != "eDP-1" ]; then
        hyprctl dispatch moveworkspacetomonitor 5 eDP-1 2>/dev/null || true
    fi
    
    # Restore focus to the workspace that was active before
    hyprctl dispatch workspace "$CURRENT_WS" 2>/dev/null || true
    
    # Fix keyboard focus by explicitly refocusing the active window
    # This works around a Hyprland issue where keyboard input can be lost after monitor hotplug
    sleep 0.1
    ACTIVE_ADDR=$(hyprctl activewindow -j 2>/dev/null | jq -r '.address // empty' || echo "")
    if [ -n "$ACTIVE_ADDR" ]; then
        hyprctl dispatch focuswindow "address:$ACTIVE_ADDR" 2>/dev/null || true
    fi
fi

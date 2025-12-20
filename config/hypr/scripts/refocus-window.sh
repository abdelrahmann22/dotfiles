#!/usr/bin/env bash
# Workaround for Hyprland keyboard focus loss after monitor hotplug
# This script explicitly refocuses the active window to restore keyboard input

set -euo pipefail

sleep 0.1

ACTIVE_ADDR=$(hyprctl activewindow -j 2>/dev/null | jq -r '.address // empty' || echo "")
if [ -n "$ACTIVE_ADDR" ]; then
    hyprctl dispatch focuswindow "address:$ACTIVE_ADDR" 2>/dev/null || true
fi

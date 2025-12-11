#!/usr/bin/env bash
set -euo pipefail

# No-op if Hyprland isn't running (e.g., not in a session yet)
if [ -z "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
  exit 0
fi

# Give HDMI-A-1 a moment to report ready after resume
sleep 0.3

# Ensure we end up focused on the external monitor and its main workspace
hyprctl dispatch focusmonitor HDMI-A-1 || true
hyprctl dispatch workspace 1 || true


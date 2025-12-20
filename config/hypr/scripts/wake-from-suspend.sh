#!/usr/bin/env bash
set -euo pipefail

# Turn displays back on (don't fail the whole script if hyprctl races)
hyprctl dispatch dpms on >/dev/null 2>&1 || true

# kanshi often auto-applies 'dual-monitor' during resume hotplug; restarting helps,
# but we also re-apply our desired state once (apply-display-profile handles late eDP).
systemctl --user restart kanshi.service >/dev/null 2>&1 || true

# Apply once; the script will defer and retry if outputs are still racing.
~/.config/hypr/scripts/apply-display-profile.sh --reason resume || true

# Restore workspaces only when we actually have dual-monitor enabled
~/.config/hypr/scripts/restore-workspaces.sh || true

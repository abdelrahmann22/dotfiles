#!/usr/bin/env bash
# Dynamic hyprlock launcher that adjusts widget monitor placement
# based on currently connected displays.
# Widgets (input-field, labels) go to HDMI-A-1 if connected, otherwise eDP-1.
# Background remains on all monitors.

set -euo pipefail

get_preferred_monitor() {
    # Prefer HDMI-A-1 if enabled, otherwise eDP-1
    local monitors_json hdmi
    monitors_json="$(hyprctl monitors -j 2>/dev/null || echo '[]')"
    hdmi="$(echo "$monitors_json" | jq -r '.[] | select(.name=="HDMI-A-1" and (.disabled|not)) | .name' | head -n1 || true)"
    if [[ -n "${hdmi:-}" ]]; then
        echo "HDMI-A-1"
    else
        echo "eDP-1"
    fi
}

PREFERRED_MONITOR="$(get_preferred_monitor)"

# Generate dynamic hyprlock config with the preferred monitor
DYNAMIC_CONFIG="/tmp/hyprlock-dynamic.conf"

cat > "$DYNAMIC_CONFIG" << EOF
# Dynamically generated hyprlock config
# Widget monitor: $PREFERRED_MONITOR

# BACKGROUND (all monitors)
background {
    monitor = 
    path = $(grep -oP 'path = \K.*' ~/.config/hypr/hyprlock.conf 2>/dev/null | head -1 || echo "screenshot")
}

# GENERAL
general {
    no_fade_in = false
    no_fade_out = false
    hide_cursor = true
    grace = 0
    disable_loading_bar = true
    ignore_empty_input = true
}

# INPUT FIELD (preferred monitor only)
input-field {
    monitor = $PREFERRED_MONITOR
    size = 250, 60
    outline_thickness = 2
    dots_size = 0.2
    dots_spacing = 0.35
    dots_center = true
    outer_color = rgba(0, 0, 0, 0)
    inner_color = rgba(0, 0, 0, 0.3)
    font_color = rgb(255, 255, 255)
    fade_on_empty = true
    fade_timeout = 1000
    rounding = -1
    placeholder_text = Password
    hide_input = false
    position = 0, -200
    halign = center
    valign = center
    check_color = rgb(919190)
    fail_color = rgb(ffb4ab)
    fail_text = <b>\$ATTEMPTS</b>
    fail_timeout = 2000
    fail_transition = 300
}

# DATE (preferred monitor only)
label {
    monitor = $PREFERRED_MONITOR
    text = cmd[update:1000] date +"%A, %B %d"
    color = rgb(e3e2e2)
    font_size = 22
    font_family = JetBrains Mono
    position = 0, 300
    halign = center
    valign = center
}

# TIME (preferred monitor only)
label {
    monitor = $PREFERRED_MONITOR
    text = cmd[update:1000] date +"%-I:%M"
    color = rgb(e3e2e2)
    font_size = 95
    font_family = JetBrains Mono Extrabold
    position = 0, 200
    halign = center
    valign = center
}
EOF

# Launch hyprlock with the dynamic config
exec hyprlock --config "$DYNAMIC_CONFIG"

#!/usr/bin/env bash
# Dynamic hyprlock launcher that generates config at lock time
# Shows widgets on the preferred monitor (HDMI if connected, otherwise all monitors)
# Also gets the current wallpaper from waypaper config

set -euo pipefail

get_preferred_monitor() {
    # Prefer HDMI-A-1 if enabled, otherwise empty (all monitors)
    local monitors_json hdmi edp
    monitors_json="$(hyprctl monitors -j 2>/dev/null || echo '[]')"
    hdmi="$(echo "$monitors_json" | jq -r '.[] | select(.name=="HDMI-A-1" and (.disabled|not)) | .name' | head -n1 || true)"
    edp="$(echo "$monitors_json" | jq -r '.[] | select(.name=="eDP-1" and (.disabled|not)) | .name' | head -n1 || true)"
    
    # If both monitors are connected, use HDMI
    # If only one monitor, leave empty (show on all/that one)
    if [[ -n "${hdmi:-}" && -n "${edp:-}" ]]; then
        echo "HDMI-A-1"
    else
        echo ""  # Empty = all monitors (or the only one connected)
    fi
}

get_current_wallpaper() {
    local wp=""
    # Try waypaper config first
    if [[ -f "$HOME/.config/waypaper/config.ini" ]]; then
        wp=$(grep -oP '^wallpaper\s*=\s*\K.*' "$HOME/.config/waypaper/config.ini" | head -1 || true)
        wp="${wp/#\~/$HOME}"
    fi
    # Fallback to hyprpaper config
    if [[ -z "$wp" || ! -f "$wp" ]]; then
        wp=$(grep -oP '^preload\s*=\s*\K.*' "$HOME/.config/hypr/hyprpaper.conf" | head -1 || true)
        wp="${wp/#\~/$HOME}"
    fi
    # Final fallback
    if [[ -z "$wp" || ! -f "$wp" ]]; then
        echo "screenshot"
    else
        echo "$wp"
    fi
}

PREFERRED_MONITOR="$(get_preferred_monitor)"
WALLPAPER="$(get_current_wallpaper)"

# Generate dynamic hyprlock config with the preferred monitor
DYNAMIC_CONFIG="/tmp/hyprlock-dynamic.conf"

cat > "$DYNAMIC_CONFIG" << EOF
# Dynamically generated hyprlock config
# Widget monitor: ${PREFERRED_MONITOR:-all}
# Wallpaper: $WALLPAPER

# BACKGROUND (all monitors)
background {
    monitor = 
    path = $WALLPAPER
}

# GENERAL
general {
    hide_cursor = true
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

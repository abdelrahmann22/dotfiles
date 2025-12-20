#!/usr/bin/env bash
set -euo pipefail

# Idempotent waybar launcher: only restarts if the desired output changed
# or waybar is not running. Tracks current state to avoid unnecessary flicker.

# Prevent race conditions but don't block on stale locks.
# If we can't get the lock immediately, kill waybar and take over.
LOCK_FILE="/tmp/waybar-launch.lock"
exec 9>"$LOCK_FILE"
if ! flock -n 9; then
  # Lock is held; forcibly kill waybar and try once more
  pkill -9 waybar 2>/dev/null || true
  sleep 0.2
  flock 9
fi

CONFIG_DIR="$HOME/.config/waybar"
TEMP_CONFIG="$(mktemp /tmp/waybar-config-XXXXXX.jsonc)"
LOG_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/hypr/waybar-launch.log"
STATE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/hypr/waybar-output.state"
mkdir -p "$(dirname "$LOG_FILE")"

exec >>"$LOG_FILE" 2>&1
echo "---- $(date -Is) launch-waybar.sh ----"

# Read last output state (if any)
LAST_OUTPUT="$(cat "$STATE_FILE" 2>/dev/null || echo "")"
echo "last_output=$LAST_OUTPUT"

# Get monitors once and query twice
MONITORS_JSON="$(hyprctl monitors -j 2>/dev/null || echo '[]')"

# Prefer HDMI if it's enabled; otherwise fall back to eDP.
OUTPUT="$(
    echo "$MONITORS_JSON" \
        | jq -r '.[] | select(.name=="HDMI-A-1" and (.disabled|not)) | .name' \
        | head -n1 \
        || true
)"
if [[ -z "${OUTPUT:-}" ]]; then
    OUTPUT="$(
        echo "$MONITORS_JSON" \
            | jq -r '.[] | select(.name=="eDP-1" and (.disabled|not)) | .name' \
            | head -n1 \
            || true
    )"
fi
OUTPUT="${OUTPUT:-eDP-1}"
echo "selected output: $OUTPUT"

# If waybar is already running on the correct output, do nothing
if [[ -n "$LAST_OUTPUT" && "$LAST_OUTPUT" == "$OUTPUT" ]] && pgrep -x waybar >/dev/null 2>&1; then
  echo "waybar already on $OUTPUT; no restart needed"
  exit 0
fi

# Different output or waybar is down; restart it
echo "restarting waybar: $LAST_OUTPUT -> $OUTPUT"
pkill -x waybar 2>/dev/null || true
sleep 0.1

# Create temporary config with the appropriate output field
sed "2a\\  \"output\": \"$OUTPUT\"," "$CONFIG_DIR/config.jsonc" > "$TEMP_CONFIG"

# Launch waybar with the temporary config (config is read immediately, so we can clean up quickly)
waybar --config "$TEMP_CONFIG" --style "$CONFIG_DIR/style.css" --log-level error >>"$LOG_FILE" 2>&1 &
echo "waybar launched with output=$OUTPUT"

# Save current output state
echo "$OUTPUT" > "$STATE_FILE"

# Start PipeWire -> Waybar signal watcher (idempotent via flock inside the script)
~/.config/waybar/scripts/pw-waybar-events.sh >/dev/null 2>&1 &

# Clean up temp config in background after waybar has loaded
(sleep 1 && rm -f "$TEMP_CONFIG") &

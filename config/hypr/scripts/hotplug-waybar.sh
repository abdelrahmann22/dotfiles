#!/usr/bin/env bash
set -euo pipefail

# Dynamic waybar launcher for Hyprland monitor hotplug events.
# Listens to monitor add/remove events and relaunches waybar ONLY when
# the desired output changes (e.g., switching between HDMI-A-1 and eDP-1).
# This prevents unnecessary restarts when waybar is already on the correct monitor.

LOG_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/hypr/hotplug-waybar.log"
mkdir -p "$(dirname "$LOG_FILE")"

exec >>"$LOG_FILE" 2>&1
echo "---- $(date -Is) hotplug-waybar.sh starting ----"

# Single instance guard
LOCK_FILE="/tmp/hotplug-waybar.lock"
exec 9>"$LOCK_FILE"
if ! flock -n 9; then
  echo "another instance already running"
  exit 0
fi

PENDING_PID=""
cleanup() {
  if [[ -n "${PENDING_PID:-}" ]]; then
    kill "$PENDING_PID" >/dev/null 2>&1 || true
  fi
}
trap cleanup EXIT

# Wait for Hyprland socket to be ready
for _ in $(seq 1 40); do
  if [[ -S "${XDG_RUNTIME_DIR}/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock" ]]; then
    break
  fi
  sleep 0.1
done

echo "listening for monitor events on socket: ${XDG_RUNTIME_DIR}/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock"

# Track last monitor config to avoid redundant relaunches
LAST_STATE_FILE="/tmp/waybar-monitor-state"
touch "$LAST_STATE_FILE"

get_monitor_state() {
  hyprctl monitors -j 2>/dev/null | jq -r '.[] | "\(.name):\(.disabled)"' | sort | tr '\n' ',' || echo ""
}

get_desired_output() {
  # Prefer HDMI if enabled, otherwise eDP - cache monitors JSON
  local monitors_json hdmi edp
  monitors_json="$(hyprctl monitors -j 2>/dev/null || echo '[]')"
  hdmi="$(echo "$monitors_json" | jq -r '.[] | select(.name=="HDMI-A-1" and (.disabled|not)) | .name' | head -n1 || true)"
  if [[ -n "${hdmi:-}" ]]; then
    echo "HDMI-A-1"
    return
  fi
  edp="$(echo "$monitors_json" | jq -r '.[] | select(.name=="eDP-1" and (.disabled|not)) | .name' | head -n1 || true)"
  echo "${edp:-eDP-1}"
}

# Track desired output in a file since socat pipeline creates subshell
WAYBAR_STATE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/hypr/waybar-output.state"
DESIRED_OUTPUT_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/hypr/waybar-desired-output.state"

# Initialize desired output state
if [[ ! -f "$DESIRED_OUTPUT_FILE" ]]; then
  INIT_OUTPUT="$(cat "$WAYBAR_STATE_FILE" 2>/dev/null || get_desired_output)"
  echo "$INIT_OUTPUT" > "$DESIRED_OUTPUT_FILE"
  echo "initialized desired_output=$INIT_OUTPUT"
fi

schedule_relaunch() {
  # Coalesce bursts of hotplug events into one relaunch after things settle.
  # This prevents flicker and avoids racing kanshi during rapid add/remove sequences.
  if [[ -n "${PENDING_PID:-}" ]]; then
    kill "$PENDING_PID" >/dev/null 2>&1 || true
    PENDING_PID=""
  fi

  (
    sleep 0.2
    ~/.config/waybar/scripts/launch-waybar.sh >/dev/null 2>&1 || true
  ) &
  PENDING_PID="$!"
}

# Listen to Hyprland monitor events (only v2 to avoid duplicate v1/v2 events).
# Auto-reconnect if socat exits (Hyprland restart, broken pipe, etc.).
SOCKET="${XDG_RUNTIME_DIR}/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock"
while true; do
  socat -U - "UNIX-CONNECT:${SOCKET}" 2>/dev/null | while read -r line; do
    if [[ "$line" == monitoraddedv2* ]] || [[ "$line" == monitorremovedv2* ]]; then
      echo "event detected: $line"

      CURRENT_STATE="$(get_monitor_state)"
      LAST_STATE="$(cat "$LAST_STATE_FILE" 2>/dev/null || echo "")"

      if [[ "$CURRENT_STATE" != "$LAST_STATE" ]]; then
        echo "monitor config changed: $LAST_STATE -> $CURRENT_STATE"
        echo "$CURRENT_STATE" >"$LAST_STATE_FILE"
        
        # Check if desired output changed before scheduling relaunch
        DESIRED_OUTPUT="$(get_desired_output)"
        LAST_DESIRED_OUTPUT="$(cat "$DESIRED_OUTPUT_FILE" 2>/dev/null || echo "")"
        
        if [[ "$DESIRED_OUTPUT" != "$LAST_DESIRED_OUTPUT" ]]; then
          echo "desired output changed: $LAST_DESIRED_OUTPUT -> $DESIRED_OUTPUT"
          echo "$DESIRED_OUTPUT" > "$DESIRED_OUTPUT_FILE"
          echo "scheduling waybar relaunch"
          schedule_relaunch
        else
          echo "desired output unchanged ($DESIRED_OUTPUT); skipping waybar relaunch"
        fi
      else
        echo "monitor config unchanged, skipping"
      fi
    fi
  done

  echo "socat disconnected; retrying in 0.5s"
  sleep 0.5
done

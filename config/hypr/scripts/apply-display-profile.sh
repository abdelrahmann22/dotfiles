#!/usr/bin/env bash
set -euo pipefail

# Robust kanshi profile applier:
# - Works for lid events + resume events
# - Retries because resume/hotplug races are common
# - Logs so we can see what happened after resume

LOG_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/hypr"
LOG_FILE="$LOG_DIR/display-fix.log"
STATE_FILE="$LOG_DIR/display-profile.state"
mkdir -p "$LOG_DIR"

exec >>"$LOG_FILE" 2>&1
echo "---- $(date -Is) apply-display-profile.sh $* ----"

REASON=""
if [[ "${1:-}" == "--reason" ]]; then
  REASON="${2:-}"
fi
echo "reason=${REASON:-none}"

ensure_hypr_sig() {
  if [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
    return 0
  fi
  if [[ -n "${XDG_RUNTIME_DIR:-}" && -d "$XDG_RUNTIME_DIR/hypr" ]]; then
    # Pick the first available instance dir.
    local sig
    sig="$(ls -1 "$XDG_RUNTIME_DIR/hypr" 2>/dev/null | head -n1 || true)"
    if [[ -n "${sig:-}" ]]; then
      export HYPRLAND_INSTANCE_SIGNATURE="$sig"
      echo "HYPRLAND_INSTANCE_SIGNATURE inferred: $HYPRLAND_INSTANCE_SIGNATURE"
    fi
  fi
}

lid_state() {
  local f
  for f in /proc/acpi/button/lid/*/state; do
    if [[ -f "$f" ]]; then
      awk '{print $2}' "$f"
      return 0
    fi
  done
  echo "unknown"
}

lid_state_stable() {
  # Immediately after resume, lid state can briefly be wrong.
  # Sample a few times and treat any observed "closed" as authoritative.
  local samples=10
  local sleep_s=0.1
  local saw_open="no"
  local s
  for _ in $(seq 1 "$samples"); do
    s="$(lid_state)"
    if [[ "$s" == "closed" ]]; then
      echo "closed"
      return 0
    fi
    if [[ "$s" == "open" ]]; then
      saw_open="yes"
    fi
    sleep "$sleep_s"
  done
  if [[ "$saw_open" == "yes" ]]; then
    echo "open"
  else
    echo "unknown"
  fi
}

mon_disabled() {
  local name="$1"
  # prints: true/false/empty
  hyprctl monitors -j 2>/dev/null | jq -r --arg n "$name" '.[] | select(.name==$n) | .disabled' | head -n1 || true
}

mon_present() {
  local name="$1"
  hyprctl monitors -j 2>/dev/null | jq -e --arg n "$name" '.[] | select(.name==$n)' >/dev/null 2>&1
}

wait_for_monitor_present() {
  local name="$1"
  local seconds="${2:-8}"
  local i
  for i in $(seq 1 $((seconds * 10))); do
    if mon_present "$name"; then
      return 0
    fi
    sleep 0.1
  done
  return 1
}

spawn_deferred_apply() {
  local desired="$1"
  local wait_secs="${2:-25}"
  local log="$3"

  (
    exec >>"$log" 2>&1
    echo "---- $(date -Is) deferred-apply desired=$desired wait=${wait_secs}s ----"

    # Give the compositor a moment to react to lid-open before we start polling.
    sleep 0.2

    local i
    for i in $(seq 1 $((wait_secs * 10))); do
      if hyprctl monitors -j >/dev/null 2>&1 && mon_present "eDP-1"; then
        echo "deferred: eDP-1 present; switching to $desired"
        kanshictl switch "$desired" >/dev/null 2>&1 || true
        exit 0
      fi
      sleep 0.1
    done

    echo "deferred: timed out waiting for eDP-1; giving up"
    exit 0
  ) &
  disown || true
}

ensure_hypr_sig

# Wait for Hyprland socket/monitors to be ready
for _ in $(seq 1 40); do
  if hyprctl monitors -j >/dev/null 2>&1; then
    break
  fi
  sleep 0.1
done

if [[ "$REASON" == resume* ]]; then
  LID="$(lid_state_stable)"
else
  LID="$(lid_state)"
fi
HDMI_PRESENT="no"
if mon_present "HDMI-A-1"; then
  HDMI_PRESENT="yes"
fi

DESIRED=""
if [[ "$HDMI_PRESENT" == "yes" ]]; then
  if [[ "$LID" == "closed" ]]; then
    DESIRED="lid-closed"
  else
    DESIRED="dual-monitor"
  fi
else
  DESIRED="laptop-only"
fi

echo "lid=$LID hdmi_present=$HDMI_PRESENT desired=$DESIRED"

verify_ok() {
  case "$DESIRED" in
    lid-closed)
      # When the lid is closed, some systems completely remove eDP from the output list.
      # Consider both "missing" and "disabled=true" as acceptable.
      if mon_present "eDP-1"; then
        [[ "$(mon_disabled "eDP-1")" == "true" && "$(mon_disabled "HDMI-A-1")" == "false" ]]
      else
        [[ "$(mon_disabled "HDMI-A-1")" == "false" ]]
      fi
      ;;
    dual-monitor)
      [[ "$(mon_disabled "eDP-1")" == "false" && "$(mon_disabled "HDMI-A-1")" == "false" ]]
      ;;
    laptop-only)
      [[ "$(mon_disabled "eDP-1")" == "false" ]]
      ;;
    *)
      return 1
      ;;
  esac
}

# Avoid unnecessary monitor reconfiguration (visible "refresh") when we already
# have the correct end state and this script is triggered multiple times.
LAST_DESIRED=""
if [[ -f "$STATE_FILE" ]]; then
  LAST_DESIRED="$(cat "$STATE_FILE" 2>/dev/null || true)"
fi
if [[ -n "$LAST_DESIRED" && "$LAST_DESIRED" == "$DESIRED" ]]; then
  if verify_ok; then
    echo "ok: already applied=$DESIRED"
    exit 0
  fi
fi

# Best UX on lid-open/resume: do not block waiting for eDP to come back.
# If eDP is currently missing, schedule a single deferred apply and return.
if [[ ("$REASON" == "lid-on" || "$REASON" == resume*) && "$DESIRED" == "dual-monitor" ]]; then
  if ! mon_present "eDP-1"; then
    echo "info: eDP-1 not present yet; deferring profile apply"
    spawn_deferred_apply "$DESIRED" 25 "$LOG_FILE"
    exit 0
  fi
fi

# Apply once, then verify a few times (verification is cheap; switching is what causes refresh).
kanshictl switch "$DESIRED" >/dev/null 2>&1 || true

MAX_VERIFY=25
SLEEP_VERIFY=0.12

for attempt in $(seq 1 "$MAX_VERIFY"); do
  echo "verify=$attempt desired=$DESIRED (eDP.present=$(mon_present "eDP-1" && echo yes || echo no) eDP.disabled=$(mon_disabled "eDP-1") hdmi.disabled=$(mon_disabled "HDMI-A-1"))"
  if verify_ok; then
    echo "$DESIRED" >"$STATE_FILE" 2>/dev/null || true
    echo "ok: applied=$DESIRED"
    exit 0
  fi
  sleep "$SLEEP_VERIFY"
done

# Last resort: for lid events where things are stuck, try one extra switch after a short wait.
if [[ "$REASON" == lid-* ]]; then
  echo "warn: not converged yet; last-resort re-switch"
  sleep 0.3
  kanshictl switch "$DESIRED" >/dev/null 2>&1 || true
  sleep 0.3
  if verify_ok; then
    echo "$DESIRED" >"$STATE_FILE" 2>/dev/null || true
    echo "ok: applied=$DESIRED"
    exit 0
  fi
fi

echo "warn: failed to converge to $DESIRED (final eDP.disabled=$(mon_disabled "eDP-1") hdmi.disabled=$(mon_disabled "HDMI-A-1"))"
exit 0

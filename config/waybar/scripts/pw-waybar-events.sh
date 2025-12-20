#!/usr/bin/env bash
set -euo pipefail

# Event-driven refresh for Waybar PipeWire-based modules.
# Watches PipeWire graph changes and triggers Waybar custom-module signals.
#
# Signals used (must match waybar config):
# - mic indicator:        SIGRTMIN+9
# - screen recording:     SIGRTMIN+10

LOCK_FILE="/tmp/waybar-pw-events.lock"
exec 9>"$LOCK_FILE"
flock -n 9 || exit 0

MIC_SIG=9
REC_SIG=10

notify_waybar() {
  pkill -SIGRTMIN+"$MIC_SIG" waybar 2>/dev/null || true
  pkill -SIGRTMIN+"$REC_SIG" waybar 2>/dev/null || true
}

# Initial refresh once Waybar is up
sleep 1
notify_waybar

# Debounce: don't spam signals if PipeWire is chatty
last_ms=0
now_ms() { date +%s%3N; }

# pw-mon is a long-running monitor. We don't parse it; any output means "something changed".
pw-mon -p 2>/dev/null | while IFS= read -r _line; do
  ms="$(now_ms)"
  if (( ms - last_ms < 300 )); then
    continue
  fi
  last_ms="$ms"
  notify_waybar
done

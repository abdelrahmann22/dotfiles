#!/usr/bin/env bash
set -euo pipefail

# Low-overhead CPU/RAM tooltip for Waybar.
# - Reads /proc directly (no `top`/`free`)
# - Uses a tiny cache file to compute CPU% between runs

STATE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/waybar"
STATE_FILE="$STATE_DIR/cpu.prev"
mkdir -p "$STATE_DIR"

# /proc/stat: cpu  user nice system idle iowait irq softirq steal guest guest_nice
read -r _ user nice system idle iowait irq softirq steal _ < /proc/stat
total=$((user + nice + system + idle + iowait + irq + softirq + steal))
idle_all=$((idle + iowait))

prev_total=0
prev_idle=0
if [[ -f "$STATE_FILE" ]]; then
  read -r prev_total prev_idle < "$STATE_FILE" || true
fi
printf '%s %s\n' "$total" "$idle_all" > "$STATE_FILE"

cpu_pct=0
dt=$((total - prev_total))
di=$((idle_all - prev_idle))
if (( dt > 0 )); then
  cpu_pct=$(( ( (dt - di) * 100 ) / dt ))
fi

# Memory from /proc/meminfo (kB)
mem_total_kb=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)
mem_available_kb=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
mem_used_kb=$((mem_total_kb - mem_available_kb))
mem_pct=$(( (mem_used_kb * 100) / mem_total_kb ))

# Cheap GiB formatting
mem_used_gib=$(awk -v kb="$mem_used_kb" 'BEGIN { printf "%.1f", kb/1024/1024 }')
mem_total_gib=$(awk -v kb="$mem_total_kb" 'BEGIN { printf "%.1f", kb/1024/1024 }')

echo "{\"text\": \"󰍛\", \"tooltip\": \"CPU: ${cpu_pct}%\\nRAM: ${mem_used_gib}GiB / ${mem_total_gib}GiB (${mem_pct}%)\"}"

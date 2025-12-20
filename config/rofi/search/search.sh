#!/usr/bin/env bash
set -euo pipefail

# Prevent accidental double-launch (spamming hotkey)
LOCK_FILE="/tmp/rofi.lock"
exec 9>"$LOCK_FILE"
flock -n 9 || exit 0

dir="$HOME/.config/rofi/search"
theme='search-style'

## Run rofi with combi mode for universal search (Flow Launcher style)
exec rofi \
    -show combi \
    -combi-modes "drun,folders:${dir}/folders.sh" \
    -theme "${dir}/${theme}.rasi" \
    -no-custom \
    -matching normal \
    -sorting-method fzf \
    -show-icons \
    -combi-display-format "{text}" \
    -display-combi "Search"

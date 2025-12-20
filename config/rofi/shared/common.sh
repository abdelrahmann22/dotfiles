#!/usr/bin/env bash
# Shared rofi utilities
# Source this file in rofi scripts: source "$HOME/.config/rofi/shared/common.sh"

set -euo pipefail

# Prevent accidental double-launch (spamming hotkey)
LOCK_FILE="/tmp/rofi.lock"
exec 9>"$LOCK_FILE"
flock -n 9 || exit 0

# Common variables
ROFI_DIR="$HOME/.config/rofi"
ROFI_THEME='style-1'

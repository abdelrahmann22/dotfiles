#!/usr/bin/env bash
set -euo pipefail

# Wallpaper application script with parallel app reloads
# Usage: apply-wallpaper.sh <wallpaper_path> [matugen_type]
# Example: apply-wallpaper.sh ~/Pictures/wall.jpg scheme-expressive

WALLPAPER_PATH="${1:-}"
MATUGEN_TYPE="${2:-${MATUGEN_TYPE:-scheme-neutral}}"
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

if [ -z "$WALLPAPER_PATH" ]; then
    echo "Error: No wallpaper path provided"
    exit 1
fi

# Prevent overlapping runs (e.g. spam-clicking wallpapers)
LOCK_FILE="/tmp/matugen-apply-wallpaper.lock"
exec 9>"$LOCK_FILE"
flock -n 9 || exit 0

# Run matugen to generate colors (template generation)
matugen image --type "$MATUGEN_TYPE" "$WALLPAPER_PATH"

# Now reload all apps in background (non-blocking)
"$SCRIPT_DIR/reload-apps.sh" &

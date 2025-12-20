#!/usr/bin/env bash

if [ -z "$1" ]; then
    # List all directories recursively from HOME (excluding hidden and cache)
    find "$HOME" -maxdepth 5 -type d \
        ! -path '*/\.*' \
        ! -path '*/.cache/*' \
        ! -path '*/.local/share/Trash/*' \
        ! -path '*/node_modules/*' \
        ! -path '*/__pycache__/*' \
        2>/dev/null | while read -r fullpath; do
            shortpath="${fullpath/#$HOME\//}"
            printf '%s\0icon\x1ffolder\x1finfo\x1f%s\n' "$shortpath" "$fullpath"
        done
else
    # Selection made - ROFI_INFO contains the full path
    if [ -n "$ROFI_INFO" ]; then
        selected="$ROFI_INFO"
    else
        selected="${1/#\~/$HOME}"
    fi
    nohup nautilus "$selected" >/dev/null 2>&1 &
    disown
fi

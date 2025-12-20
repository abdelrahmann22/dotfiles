#!/usr/bin/env bash
source "$HOME/.config/rofi/shared/common.sh"

## Run
rofi \
    -modi "clipboard:$HOME/.config/rofi/clipboard/cliphist-rofi" \
    -show clipboard \
    -theme "${ROFI_DIR}/${ROFI_THEME}.rasi"

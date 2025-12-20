#!/usr/bin/env bash
source "$HOME/.config/rofi/shared/common.sh"

## Run
exec rofi \
    -show drun \
    -theme "${ROFI_DIR}/${ROFI_THEME}.rasi"

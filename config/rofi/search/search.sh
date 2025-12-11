#!/usr/bin/env bash

dir="$HOME/.config/rofi/search"
theme='search-style'

## Run rofi with combi mode for universal search (Flow Launcher style)
rofi \
    -show combi \
    -combi-modes "drun,filebrowser" \
    -theme ${dir}/${theme}.rasi \
    -matching normal \
    -sorting-method fzf \
    -show-icons \
    -combi-display-format "{text}" \
    -display-combi "Search"


#!/bin/bash

# TTY-Clock wrapper with matugen colors
# Color mapping: use color index that best matches your theme
# tty-clock uses terminal colors 0-7:
# 0=black, 1=red, 2=green, 3=yellow, 4=blue, 5=magenta, 6=cyan, 7=white

# Use terminal color 4 (blue) which should map to your primary color
# through your terminal theme

tty-clock -c -C 4 "$@"

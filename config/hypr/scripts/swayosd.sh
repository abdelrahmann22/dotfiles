#!/bin/bash

# Prefer the external monitor, fall back to focused or first active.
PRIMARY="HDMI-A-1"
monitor="$(hyprctl monitors -j | jq -r --arg primary "$PRIMARY" '
  (map(select(.name == $primary and .disabled == false)) | first | .name) //
  (map(select(.focused == true)) | first | .name) //
  (map(select(.disabled == false)) | first | .name)
')"

exec swayosd-client --monitor "${monitor}" "$@"




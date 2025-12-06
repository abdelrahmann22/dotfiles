#!/bin/bash

# Check DNF updates - only count lines that match package format (name.arch)
dnf_updates=$(dnf check-update -q 2>/dev/null | grep -E "^[a-zA-Z0-9_+-]+\.[a-zA-Z0-9_]+[[:space:]]" | wc -l)

# Check Flatpak updates
flatpak_updates=$(flatpak remote-ls --updates 2>/dev/null | wc -l)

# Total updates
total=$((dnf_updates + flatpak_updates))

if [ "$total" -gt 0 ]; then
  tooltip="DNF: $dnf_updates\nFlatpak: $flatpak_updates"
  echo "{\"text\":\"$total\",\"class\":\"pending\",\"tooltip\":\"$tooltip\"}"
else
  echo "{\"text\":\"\",\"class\":\"updated\",\"tooltip\":\"System up to date\"}"
fi






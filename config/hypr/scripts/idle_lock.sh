#!/bin/bash
# Script to lock session only if no audio is playing
# Used by hypridle to avoid locking during calls or audio playback

# Check for running audio streams using pactl (PulseAudio/PipeWire)
if pactl list sink-inputs 2>/dev/null | grep -q 'State: RUNNING'; then
    exit 0  # Audio is playing, don't lock
fi

# Alternative check using wpctl for PipeWire
if command -v wpctl &>/dev/null; then
    if wpctl status 2>/dev/null | grep -q 'running'; then
        exit 0  # Audio is playing, don't lock
    fi
fi

# No audio playing, proceed with lock
loginctl lock-session

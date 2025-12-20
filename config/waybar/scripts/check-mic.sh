#!/usr/bin/env bash

# Check PipeWire for active microphone capture streams
if command -v pw-dump >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
    mic_info=$(pw-dump 2>/dev/null | jq -er '
        .[] 
        | select(.info.state == "running")
        | select(.info.props."media.class" == "Stream/Input/Audio")
        | .info.props."application.name" // .info.props."node.name" // empty
    ' 2>/dev/null | head -n1)

    if [ -n "$mic_info" ]; then
        # Get mic volume
        volume=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null | awk '{print int($2 * 100)}')
        muted=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null | grep -q MUTED && echo "yes" || echo "no")
        
        if [ "$muted" = "yes" ]; then
            echo "{\"text\":\"󰍭\",\"tooltip\":\"Mic muted - $mic_info\",\"class\":\"muted\"}"
        else
            echo "{\"text\":\"󰍬\",\"tooltip\":\"Mic: ${volume}% - $mic_info\",\"class\":\"active\"}"
        fi
        exit 0
    fi
fi

# No mic usage detected - output empty to hide the module
echo "{\"text\":\"\",\"tooltip\":\"\",\"class\":\"inactive\"}"

#!/usr/bin/env bash

# Check PipeWire for active screen capture/recording streams
if command -v pw-dump >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
    pw_info=$(pw-dump 2>/dev/null | jq -er '
        .[] 
        | select(.info.state == "running")
        | select(.info.props."media.class" == "Stream/Input/Video" or .info.props."media.name" == "webrtc-consume-stream")
        | .info.props."application.name" // .info.props."node.name" // empty
    ' 2>/dev/null | head -n1)

    if [ -n "$pw_info" ]; then
        echo "{\"text\":\"󰹑\",\"tooltip\":\"Screen recording: $pw_info\",\"class\":\"recording\"}"
        exit 0
    fi
fi

# No recording detected - output empty to hide the module
echo "{\"text\":\"\",\"tooltip\":\"\",\"class\":\"idle\"}"






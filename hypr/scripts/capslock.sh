#!/bin/bash

# Check if capslock is on
if [ "$(xset q | grep Caps | awk '{print $4}')" = "on" ]; then
    echo "  CAPS LOCK ON"
else
    echo ""
fi


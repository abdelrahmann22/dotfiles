#!/bin/bash

# Brightness control script with mako notifications

get_brightness() {
    brightnessctl get
}

get_max_brightness() {
    brightnessctl max
}

get_brightness_percent() {
    current=$(get_brightness)
    max=$(get_max_brightness)
    echo $((current * 100 / max))
}

get_brightness_icon() {
    brightness=$1
    
    if [ "$brightness" -lt 25 ]; then
        echo "󰃞"
    elif [ "$brightness" -lt 50 ]; then
        echo "󰃟"
    elif [ "$brightness" -lt 75 ]; then
        echo "󰃠"
    else
        echo "󰃡"
    fi
}

send_notification() {
    brightness=$(get_brightness_percent)
    icon=$(get_brightness_icon "$brightness")
    notify-send -t 1000 -h string:x-canonical-private-synchronous:brightness -h int:value:"$brightness" -a "brightness" "$icon brightness : ${brightness}%" -u low
}

case $1 in
    up)
        brightnessctl set 5%+
        send_notification
        ;;
    down)
        brightnessctl set 5%-
        send_notification
        ;;
esac


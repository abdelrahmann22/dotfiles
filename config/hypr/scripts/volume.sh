#!/bin/bash

# Volume control script with mako notifications

# Get volume info once and parse both values
get_volume_info() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@
}

get_volume() {
    echo "$1" | awk '{print int($2 * 100)}'
}

get_mute_status() {
    echo "$1" | grep -q "MUTED" && echo "yes" || echo "no"
}

get_volume_icon() {
    volume=$1
    mute=$2
    
    if [ "$mute" = "yes" ]; then
        echo "󰖁"
    elif [ "$volume" -lt 25 ]; then
        echo "󰕿"
    elif [ "$volume" -lt 50 ]; then
        echo "󰖀"
    elif [ "$volume" -lt 75 ]; then
        echo "󰕾"
    else
        echo "󰕾"
    fi
}

send_notification() {
    local info
    info=$(get_volume_info)
    volume=$(get_volume "$info")
    mute=$(get_mute_status "$info")
    icon=$(get_volume_icon "$volume" "$mute")
    
    if [ "$mute" = "yes" ]; then
        notify-send -t 1000 -h string:x-canonical-private-synchronous:volume -h int:value:0 -a "volume" "$icon volume : Muted" -u low
    else
        notify-send -t 1000 -h string:x-canonical-private-synchronous:volume -h int:value:"$volume" -a "volume" "$icon volume : ${volume}%" -u low
    fi
}

case $1 in
    up)
        wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        send_notification
        ;;
    down)
        wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        send_notification
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        send_notification
        ;;
esac

#!/usr/bin/env bash

# Current Theme
dir="$HOME/.config/rofi/powermenu/type-2"
theme='style-5'

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
shutdown=''
reboot=''
lock='󰌾'
suspend='󰒲'
logout='󰍃'
yes=''
no=''

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "Uptime: $uptime" \
		-mesg "Uptime: $uptime" \
		-theme ${dir}/${theme}.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${dir}/${theme}.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Determine how to terminate the current desktop session gracefully.
logout_session() {
	local session="${DESKTOP_SESSION,,}"
	local current_desktop="${XDG_CURRENT_DESKTOP,,}"
	
	# Check both DESKTOP_SESSION and XDG_CURRENT_DESKTOP
	case "$session$current_desktop" in
		*openbox*)
			openbox --exit
			return
			;;
		*bspwm*)
			bspc quit
			return
			;;
		*i3*)
			i3-msg exit
			return
			;;
		*plasma*|*kde*)
			qdbus org.kde.ksmserver /KSMServer logout 0 0 0
			return
			;;
		*xfce*)
			if command -v xfce4-session-logout >/dev/null 2>&1; then
				xfce4-session-logout --logout >/dev/null 2>&1
			else
				killall xfce4-session
			fi
			return
			;;
		*hyprland*)
			hyprctl dispatch exit
			return
			;;
		*gnome*)
			if command -v gnome-session-quit >/dev/null 2>&1; then
				gnome-session-quit --logout --no-prompt
				return
			fi
			;;
		*sway*)
			swaymsg exit
			return
			;;
	esac

	# Fallback: detect by running process
	if pgrep -x Hyprland >/dev/null 2>&1; then
		hyprctl dispatch exit
		return
	elif pgrep -x sway >/dev/null 2>&1; then
		swaymsg exit
		return
	elif pgrep -x i3 >/dev/null 2>&1; then
		i3-msg exit
		return
	fi

	if command -v loginctl >/dev/null 2>&1; then
		if [[ -n "$XDG_SESSION_ID" ]]; then
			loginctl terminate-session "$XDG_SESSION_ID" && return
		else
			loginctl terminate-user "$USER" && return
		fi
	fi

	pkill -KILL -u "$USER"
}

# Execute Command
run_cmd() {
	if [[ $1 == '--shutdown' ]]; then
		systemctl poweroff
	elif [[ $1 == '--reboot' ]]; then
		systemctl reboot
	elif [[ $1 == '--suspend' ]]; then
		systemctl suspend
	elif [[ $1 == '--logout' ]]; then
		logout_session
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $lock)
		loginctl lock-session
        ;;
    $suspend)
		run_cmd --suspend
        ;;
    $logout)
		run_cmd --logout
        ;;
esac

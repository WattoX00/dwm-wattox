#!/usr/bin/env bash
set -u

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x

# CMDs
uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown='󰐥'
reboot='󰜉'
lock=''
suspend=''
logout='󰍃'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "" \
		-mesg "Uptime: $uptime" \
		-theme "$HOME/.config/rofi/themes/powermenu.rasi"
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	case $1 in
		--shutdown)
			systemctl poweroff
			;;
		--reboot)
			systemctl reboot
			;;
		--suspend)
			if command -v playerctl >/dev/null 2>&1; then
				playerctl --all-players pause
			fi
			wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
			systemctl suspend
			;;
		--logout)
			case "${DESKTOP_SESSION:-}" in
				openbox)
					openbox --exit
					;;
				bspwm)
					bspc quit
					;;
				dwm)
					pkill dwm
					;;
				i3)
					i3-msg exit
					;;
				plasma)
					qdbus org.kde.ksmserver /KSMServer logout 0 0 0
					;;
			esac
			;;
	esac
}

# Actions
chosen="$(run_rofi)"
case "${chosen}" in
    "${shutdown}")
		run_cmd --shutdown
        ;;
    "${reboot}")
		run_cmd --reboot
        ;;
    "${lock}")
		if command -v betterlockscreen >/dev/null 2>&1; then
			betterlockscreen -l
		elif command -v i3lock >/dev/null 2>&1; then
			i3lock
		else
			printf '%s\n' "No screen locker is installed; install i3lock to enable locking." >&2
			rofi -e "No screen locker is installed. Install i3lock to enable locking."
		fi
        ;;
    "${suspend}")
		run_cmd --suspend
        ;;
    "${logout}")
		run_cmd --logout
        ;;
esac

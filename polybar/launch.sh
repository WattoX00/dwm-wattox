#!/usr/bin/env bash

set -u

THEME="minimal"
UID_NUM=$(id -u)

if ! command -v polybar >/dev/null 2>&1; then
    echo "polybar launch: polybar is not installed or not on PATH" >&2
    exit 1
fi
if ! command -v xprop >/dev/null 2>&1; then
    echo "polybar launch: xprop is unavailable; cannot verify that dwm is ready" >&2
    exit 1
fi

wm_ready=false
for _ in {1..50}; do
	wm_check=$(xprop -root _NET_SUPPORTING_WM_CHECK 2>/dev/null || true)
	if [[ "$wm_check" =~ window\ id\ \#\ 0x[0-9a-fA-F]+ ]]; then
	    wm_ready=true
	    break
	fi
	sleep 0.1
done

if [[ "$wm_ready" != true ]]; then
	echo "polybar launch: EWMH window manager did not become ready within 5 seconds" >&2
	exit 1
fi

# Replace only this user's bars and wait for them to exit before relaunching.
if pgrep -u "$UID_NUM" -x polybar >/dev/null 2>&1; then
	pkill -u "$UID_NUM" -x polybar || {
	    echo "polybar launch: failed to stop existing Polybar processes" >&2
	    exit 1
	}
	for _ in {1..50}; do
	    if ! pgrep -u "$UID_NUM" -x polybar >/dev/null 2>&1; then
	        break
	    fi
	    sleep 0.1
	done
	if pgrep -u "$UID_NUM" -x polybar >/dev/null 2>&1; then
	    echo "polybar launch: existing Polybar processes did not exit within 5 seconds" >&2
	    exit 1
	fi
fi

CONFIG_FILE="$HOME/.local/share/dwm-wattox/polybar/themes/$THEME/config.ini"
LAPTOP_CONFIG_FILE="$HOME/.local/share/dwm-wattox/polybar/themes/$THEME/laptop-config.ini"

BATTERY=""
AC_ADAPTER=""
for supply in /sys/class/power_supply/*; do
	[[ -r "$supply/type" ]] || continue
	case "$(cat "$supply/type")" in
	    Battery)
	        [[ -n "$BATTERY" ]] || BATTERY=${supply##*/}
	        ;;
	    Mains)
	        [[ -n "$AC_ADAPTER" ]] || AC_ADAPTER=${supply##*/}
	        ;;
	esac
done

if [[ -n "$BATTERY" ]]; then
	CONFIG_FILE=$LAPTOP_CONFIG_FILE
	AC_ADAPTER=${AC_ADAPTER:-AC}
	export BATTERY AC_ADAPTER
fi

if [[ ! -r "$CONFIG_FILE" ]]; then
	echo "polybar launch: configuration is missing or unreadable: $CONFIG_FILE" >&2
	exit 1
fi

if command -v xrandr > /dev/null 2>&1; then
	MONITORS=()
	mapfile -t MONITORS < <(xrandr --query | awk '$2 == "connected" { print $1 }')
	MONITOR_COUNT=${#MONITORS[@]}

	if [[ "$MONITOR_COUNT" -eq 0 ]]; then
	    echo "polybar launch: xrandr reported no connected monitors" >&2
	    exit 1
	fi

	PRIMARY_MONITOR=$(xrandr --query | awk '$2 == "connected" && $3 == "primary" { print $1; exit }')
	if [[ -z "$PRIMARY_MONITOR" ]]; then
	    PRIMARY_MONITOR=${MONITORS[0]}
	    echo "No primary monitor detected, using first monitor: $PRIMARY_MONITOR"
	fi

	echo "Detected $MONITOR_COUNT monitors: ${MONITORS[*]}"

	if [[ "$MONITOR_COUNT" -eq 1 ]]; then
	    MONITOR=${MONITORS[0]} polybar main -c "$CONFIG_FILE" &
	else
	    for monitor in "${MONITORS[@]}"; do
	        if [[ "$monitor" == "$PRIMARY_MONITOR" ]]; then
	            MONITOR=$monitor polybar main -c "$CONFIG_FILE" &
	        else
	            MONITOR=$monitor polybar secondary -c "$CONFIG_FILE" &
	        fi
	    done
	fi
else
	echo "polybar launch: xrandr is unavailable; starting one bar with automatic monitor selection" >&2
	MONITOR='' polybar main -c "$CONFIG_FILE" &
fi

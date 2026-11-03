#!/usr/bin/env bash

THEME="minimal"

RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$UID}"
if [ ! -d "$RUNTIME_DIR" ] || [ ! -w "$RUNTIME_DIR" ]; then
	printf 'Polybar launcher: runtime directory is unavailable: %s\n' "$RUNTIME_DIR" >&2
	exit 1
fi
if ! command -v flock >/dev/null 2>&1; then
	printf '%s\n' 'Polybar launcher: flock is required for single-instance startup' >&2
	exit 1
fi

DISPLAY_ID="${DISPLAY:-unknown}"
DISPLAY_ID="${DISPLAY_ID//[^[:alnum:]]/_}"
exec 9>"$RUNTIME_DIR/dwm-polybar-$DISPLAY_ID.lock"
if ! flock -n 9; then
	printf 'Polybar launcher: already running on display %s; skipping duplicate launch\n' "${DISPLAY:-unknown}" >&2
	exit 0
fi

CONFIG_FILE="$HOME/.local/share/dwm-wattox/polybar/themes/$THEME/config.ini"
LAPTOP_CONFIG_FILE="$HOME/.local/share/dwm-wattox/polybar/themes/$THEME/laptop-config.ini"

if ls /sys/class/power_supply/ 2>/dev/null | grep -q '^BAT'; then
	CONFIG_FILE=$LAPTOP_CONFIG_FILE
fi

# Check if xrandr is available and get monitor list
if command -v xrandr > /dev/null 2>&1; then
    # Get list of connected monitors
    mapfile -t MONITORS < <(xrandr --query | grep " connected" | cut -d" " -f1)
    MONITOR_COUNT=${#MONITORS[@]}
    
    # Detect primary monitor
    PRIMARY_MONITOR=$(xrandr --query | grep " connected primary" | cut -d" " -f1)
    
    # If no primary monitor is explicitly set, use the first one
    if [ -z "$PRIMARY_MONITOR" ]; then
        PRIMARY_MONITOR=${MONITORS[0]}
        echo "No primary monitor detected, using first monitor: $PRIMARY_MONITOR"
    else
        echo "Primary monitor detected: $PRIMARY_MONITOR"
    fi
    
    echo "Detected $MONITOR_COUNT monitors: ${MONITORS[*]}"
    
    if [ "$MONITOR_COUNT" -eq 1 ]; then
        # Single monitor setup - launch main bar with tray and EWMH
        echo "Single monitor setup - launching main polybar with tray and EWMH on ${MONITORS[0]}"
        MONITOR=${MONITORS[0]} polybar main -c "$CONFIG_FILE" &
    else
        # Multi-monitor setup
        echo "Multi-monitor setup - EWMH and systray only on primary monitor"
        
        # Launch polybar on all connected monitors
        for monitor in "${MONITORS[@]}"; do
            if [ "$monitor" = "$PRIMARY_MONITOR" ]; then
                # Primary monitor gets the tray and EWMH
                MONITOR=$monitor polybar main -c "$CONFIG_FILE" &
                echo "Launched primary polybar with tray and EWMH on $monitor"
            else
                # Secondary monitors don't get the tray or EWMH
                MONITOR=$monitor polybar secondary -c "$CONFIG_FILE" &
                echo "Launched secondary polybar without tray on $monitor"
            fi
        done
    fi
else
    # Fallback: launch main bar if xrandr is not available
    echo "xrandr not available - launching fallback main polybar with tray"
    polybar main -c "$CONFIG_FILE" &
fi

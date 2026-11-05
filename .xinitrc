#!/bin/sh

set -u

export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin${PATH:+:$PATH}"
export XDG_CURRENT_DESKTOP=dwm
export XDG_SESSION_DESKTOP=dwm
export XDG_SESSION_TYPE=x11
export DESKTOP_SESSION=dwm
export XCURSOR_THEME=Bibata-Modern-Ice
export XCURSOR_SIZE=24
export GTK_THEME=Adwaita:dark
export QT_STYLE_OVERRIDE=Fusion
export XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}"

export CM_LAUNCHER=rofi
export CM_HISTLENGTH=15
export CM_DIR="$HOME/.cache/clipmenu"
export CM_MAX_CLIPS=100
if ! mkdir -p "$CM_DIR"; then
	printf 'dwm session: unable to create clipboard cache: %s\n' "$CM_DIR" >&2
fi

if command -v xrdb >/dev/null 2>&1; then
	if [ -f "$HOME/.Xresources" ] && ! xrdb -merge "$HOME/.Xresources"; then
		printf '%s\n' "dwm session: failed to load ~/.Xresources" >&2
	fi
else
	printf '%s\n' "dwm session: xrdb is unavailable; install xorg-xrdb to load ~/.Xresources" >&2
fi

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
	if ! dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE DESKTOP_SESSION; then
		printf '%s\n' "dwm session: unable to update the D-Bus activation environment" >&2
	fi
else
	printf '%s\n' "dwm session: dbus-update-activation-environment is unavailable" >&2
fi

autostart="$HOME/.config/dwm/autostart.sh"
if [ -x "$autostart" ]; then
	"$autostart"
elif [ -r "$autostart" ]; then
	/bin/sh "$autostart"
else
	printf 'dwm session: %s is missing or unreadable\n' "$autostart" >&2
fi

exec dwm

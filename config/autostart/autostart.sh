#!/bin/sh

set -u

uid=$(id -u)

start_once() {
  process_pattern=$1
  shift

  if ! command -v "$1" >/dev/null 2>&1; then
    printf 'dwm autostart: optional command is unavailable: %s\n' "$1" >&2
    return 0
  fi

  if ! pgrep -u "$uid" -f -- "$process_pattern" >/dev/null 2>&1; then
    "$@" &
  fi
}

wallpaper_dir="$HOME/Pictures/backgrounds"
if command -v feh >/dev/null 2>&1 && [ -d "$wallpaper_dir" ]; then
  set --
  for image in "$wallpaper_dir"/*; do
    if [ -f "$image" ]; then
      set -- "$@" "$image"
    fi
  done
  if [ "$#" -gt 0 ]; then
    feh --randomize --bg-fill "$@" &
  fi
fi

start_once '(^|/)picom([[:space:]]|$)' picom --backend xrender --vsync -b
start_once '(^|/)dunst([[:space:]]|$)' dunst

polkit_agent=/usr/lib/mate-polkit/polkit-mate-authentication-agent-1
if [ -x "$polkit_agent" ]; then
  start_once 'polkit-mate-authentication-agent-1' "$polkit_agent"
else
  printf 'dwm autostart: polkit agent is missing: %s\n' "$polkit_agent" >&2
fi

start_once '(^|/)clipmenud([[:space:]]|$)' clipmenud
start_once '(^|/)nm-applet([[:space:]]|$)' nm-applet
"$HOME/.local/share/dwm-wattox/scripts/nightshift" auto &
start_once '(^|/)flameshot([[:space:]]|$)' flameshot

# Polybar is started by dwm through altbarcmd, after the window manager is ready.

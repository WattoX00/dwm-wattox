#!/bin/sh

# clipboard
clipmenud &

# system services
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
nm-applet &
dunst &
picom -b &
flameshot &

# wallpaper
feh --randomize --bg-fill ~/Pictures/backgrounds/* &

# bar
~/.local/share/dwm-wattox/polybar/launch.sh &

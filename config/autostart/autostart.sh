#!/bin/sh

# clipboard
clipmenud &

# reshift
redshift -m randr -l 47.9:20.4 -t 5500:3000 -r &

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

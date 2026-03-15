#!/bin/sh

# clipboard
clipmenud &

# redshift
# Find your coordinates: https://www.latlong.net/
# Replace 0.0:0.0 with your city's latitude:longitude
redshift -m randr -l 0.0:0.0 -t 5500:3000 -r &

# flameshot
flameshot &

# system services
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
nm-applet &
dunst &
picom -b &

# wallpaper
feh --randomize --bg-fill ~/Pictures/backgrounds/* &

# bar
~/.local/share/dwm-wattox/polybar/launch.sh &

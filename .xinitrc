#!/bin/bash

xrdb -merge ~/.Xresources
export XCURSOR_THEME=Bibata-Modern-Ice
export XCURSOR_SIZE=24
dbus-run-session -- sh -c '~/.local/share/dwm-titus/polybar/launch.sh & exec dwm'

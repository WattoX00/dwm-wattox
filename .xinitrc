#!/bin/bash

# Web-thunar bug fix
export XDG_CURRENT_DESKTOP=XFCE
export DESKTOP_SESSION=xfce

systemctl --user import-environment DISPLAY XAUTHORITY
dbus-update-activation-environment DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP DESKTOP_SESSION

xrdb -merge ~/.Xresources
export XCURSOR_THEME=Bibata-Modern-Ice
export XCURSOR_SIZE=24

rm -f "$HOME/.cache/clipmenu"/clipmenu.*."$USER"/*
export PATH=$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin
export CM_LAUNCHER="rofi"
export CM_HISTLENGTH=15
export CM_DIR="$HOME/.cache/clipmenu"
export CM_MAX_CLIPS=100

# start autostart script first
sh "$HOME/.config/autostart/autostart.sh"

# start dwm
exec dwm

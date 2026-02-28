#!/bin/bash

xrdb -merge ~/.Xresources
export XCURSOR_THEME=Bibata-Modern-Ice
export XCURSOR_SIZE=24

export PATH=$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin
export CM_LAUNCHER="rofi"
export CM_HISTLENGTH=15
export CM_DIR="$HOME/.cache/clipmenu"
export CM_MAX_CLIPS=100

# start autostart script first
sh "$HOME/.config/autostart/autostart.sh"

# finally, start dwm
exec dwm

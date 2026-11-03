# Session startup

`autostart.sh` is the single startup script for this dwm session. The
`dwm-session` launcher runs it before launching dwm, whether the session was
started by LightDM or by the optional `.xinitrc`/`startx` fallback. `make
install` installs the launcher and copies this script to
`~/.config/autostart/autostart.sh`.

Add or remove background programs in that script. Programs started there are
independent of dwm and keep running when dwm exits.

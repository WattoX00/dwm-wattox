# dwm session startup

`autostart.sh` is the single startup script for this dwm session. The
`dwm-session` launcher runs it before launching dwm, whether the session was
started by LightDM or by the optional `.xinitrc`/`startx` fallback. `make
install` creates `~/.config/dwm/autostart.sh` when it does not exist, preserving
any user-edited version on later installs.

Keep this script outside `~/.config/autostart`: that directory is reserved for
XDG `.desktop` entries and other files there may be interpreted as launch
entries by session managers. Add or remove background programs here. Programs
started by this script are independent of dwm and keep running when dwm exits.

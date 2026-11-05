# dwm session startup

`~/.xinitrc` is the single source of truth for session startup. It loads X
resources, updates the D-Bus environment, starts this script, then runs `exec
dwm`. The SDDM `dwm-session` launcher and `startx` both enter through
`~/.xinitrc`. `make install` creates `~/.config/dwm/autostart.sh` when it does
not exist, preserving any user-edited version on later installs.

Keep this script outside `~/.config/autostart`: that directory is reserved for
XDG `.desktop` entries and other files there may be interpreted as launch
entries by session managers. Add or remove background programs here. Programs
started by this script are independent of dwm and keep running when dwm exits.
Polybar is started separately by dwm after it publishes its EWMH readiness
atom, so the bar can be managed and restacked by dwm. Session processes are
started in the background so they do not delay the window manager.

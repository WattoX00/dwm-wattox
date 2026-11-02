# Session startup

`autostart.sh` is the single startup script for this dwm session. The
repository's `.xinitrc` runs it before launching dwm, and `make install`
installs it to `~/.config/autostart/autostart.sh`.

Add or remove background programs in that script. Programs started there are
independent of dwm and keep running when dwm exits.

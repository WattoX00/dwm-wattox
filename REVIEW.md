# User configuration review

Scope: files copied or run by the dwm-wattox user configuration. The dwm build,
patches, and Arch install scripts were inspected only where needed to understand
the session flow; they were not changed.

## Super+M, Polybar, and fullscreen

`Super+M` is bound in `config.h` to dwm's `fullscreen()` function. In this dwm
source, that function switches to/from the monocle layout and calls
`togglebar()`; it does not call `polybar-msg`, kill Polybar, or directly set the
client's EWMH fullscreen state. The bar is hidden by dwm moving its managed
alternate-bar window out of view. `Super+Shift+B` is the separate direct
`togglebar` binding.

The original Polybar files had `enable-ipc = false` for both bars. That would
break a `polybar-msg` command, but it is not what `Super+M` invokes. Both bars
now have IPC enabled. They also remain managed (`override-redirect = false`),
which is required for dwm's alternate-bar handling. The launcher starts named
`main`/`secondary` instances, waits up to five seconds for
`_NET_SUPPORTING_WM_CHECK`, stops existing same-user Polybar processes and
waits for exit before starting replacements. Monitor selection covers one or
many connected displays, and the no-`xrandr` fallback clears inherited
`MONITOR`.

Static inspection of this dwm confirms its setup publishes the EWMH supporting
window before calling `spawnbar()`, so there is no startup-order race in this
build; the launcher's bounded wait remains a defensive guard. No X server is
available here, so the visual failure cannot be reproduced and the live
Polybar `WM_CLASS`/stacking behavior is not verified. The code-level cause is
that the bar toggle belongs to dwm, not Polybar IPC; the IPC-disabled setting
was a separate latent issue, not the cause of this key's behavior. The in-scope
fix keeps Polybar managed and hardens startup/restarts without replacing
`Super+M` with an IPC-only command. If the bar still fails to hide after
installing the matching dwm build, verify the live bar class and window state
on the X session.

The custom `fullscreen()` implementation is a monocle-plus-bar toggle rather
than true EWMH fullscreen. Its saved `last_layout` is global, not per monitor;
multi-monitor fullscreen layout restoration should be tested. Changes to
`dwm.c` are outside this task's scope.

## Findings

| Severity | File | Issue | What changed |
|---|---|---|---|
| broken | `.xinitrc`, `scripts/dwm-session` | Startup setup lived in a second session script, so `.xinitrc` did not own the shared SDDM/startx startup path or end in `exec dwm`. | `.xinitrc` now owns environment, X resources, D-Bus update, autostart, and the single final `exec dwm`; `dwm-session` delegates to it. |
| fragile | `config/autostart/autostart.sh` | Exact process-name checks can miss long executable names such as the MATE polkit agent, allowing duplicate launches. | Idempotency checks use process command-line patterns; every optional startup command is guarded and backgrounded. Startup order is wallpaper, picom, dunst, polkit, clipboard, then other utilities. |
| fragile | `polybar/launch.sh`, `polybar/themes/minimal/*.ini` | IPC was disabled in the original bars; launcher restart/WM-readiness and monitor behavior needed hardening. | Both bars enable IPC; launch waits for the WM, kills/waits for old same-user bars, uses named bars, detects monitors and laptop power devices, and has a single-monitor/fallback path. |
| broken | `polybar/themes/minimal/modules/` and bar configs | There was no network status module despite NetworkManager being installed. | Added an `nmcli`-based module with wired, Wi-Fi, and offline states to both bar configurations. |
| fragile | `config/rofi/themes/modernrofi.rasi`, `config/fontconfig/fonts.conf` | The Rofi theme referenced Sora, which is not installed by the package list; bundled Feather/Material fonts were not registered with Fontconfig. | Switched the Rofi text font to Meslo and registered the bundled icon-font directories. |
| fragile | `config/dunst/dunstrc` | Dunst's action menu pointed to uninstalled `dmenu`; the icon path used the old GNOME directory. | Uses the installed Rofi binary and the Adwaita icon directory. |
| cosmetic | `config/gtk-2.0/settings.ini` | GTK2 selected Adwaita cursor while GTK3/GTK4/Xresources use Bibata. | Aligned GTK2 to the installed `Bibata-Modern-Ice` variant. |
| fragile | `config/alacritty/keybinds.toml` | Ctrl+Shift+Up/Down each had both scroll and font-size actions. | Kept font-size changes on Up/Down; K/J remain the line-scroll shortcuts. |
| fragile | `config/rofi/powermenu.sh` | Lock silently did nothing if neither supported screen locker was installed; logout depended on an unset-prone session variable. | Missing locker now produces an explicit message; logout handles an unset variable and uses the SDDM `dwm` session identifier. |
| fragile | `scripts/dwm-keybinds` | The help menu skipped all `TAGKEYS` macro bindings. | Added generated descriptions for each tag action; removed the unused Rofi result variable. |
| fragile | `scripts/dbus` | The executable helper had no shebang and silently depended on D-Bus tooling being present. | Added a `/bin/sh` shebang and an explicit missing-command error. The helper is not called by session startup. |
| fragile | `scripts/webapp-create`, `scripts/webapp-launch` | Web-app creation failed under `set -u` when the optional icon URL was omitted; browser selection could execute a missing browser. | Made icon URL optional, omitted a missing icon entry, corrected usage text, and fall back when a selected browser binary is unavailable. |
| fragile | `scripts/protonrestart` | Missing `killall`/`lsof` was silently ignored, so the reset could be incomplete. | The helper now reports skipped sweeps. It still needs the listed optional packages for full behavior. |
| fragile | `.bashrc` | Clipboard-manager environment duplicated the session definition; the `cch` alias had broken quoting. | Removed the duplicate exports and corrected the alias quoting. |
| fragile | `config.h`, `dwm.c` | `Super+M` invokes dwm's custom monocle/bar function, not Polybar IPC or EWMH fullscreen; the multi-monitor saved layout is shared. | No key behavior or dwm source was changed; the managed-bar path was hardened. Requires live X testing; source changes are outside scope. |
| fragile | `config/rofi/config.rasi`, `config/autostart/autostart.sh` | Rofi's Papirus icon theme is not on the package list; Redshift uses placeholder coordinates `0.0:0.0`. | Preserved both user choices. Redshift coordinates need updating; Papirus needs the package below. |
| fragile | `scripts/active-audio`, `scripts/dbus`, `polybar/themes/minimal/include-modules.ini`, `config.h` | `active-audio` has no keybinding and requires `xdotool`; the D-Bus helper is unused; several included Polybar modules are leftovers for other WMs and are not displayed; `STATUSBAR` still names `dwmblocks` although the native bar is disabled. | Kept these utilities/modules rather than removing features; noted dependencies and behavior below. |
| fragile | `config.h` power menu binding | The lock menu offers a lock action, but no locker is installed by the package line. | The action now explains the missing locker instead of silently failing. Install `i3lock` (or `betterlockscreen`) to make it functional. |
| fragile | `config.h`, `dwm.c` | There is no in-session restart binding: `Super+Shift+Q` calls dwm `quit()` and ends the SDDM session. | No restart feature was added; the bar launcher can be rerun to test idempotence, or log out and select dwm again. |

### Keybindings and scripts checked

All explicit bindings in `config.h`, the nine `TAGKEYS` expansions, and the
mouse bindings were inspected. The launcher, terminal, editor, todo/music
commands, browser, file manager, emoji picker, screenshots, wallpaper,
brightness, PipeWire volume/mute, layouts, tags, monitor movement, power menu,
and quit actions resolve to repository scripts, Arch-setup-installed apps, or
packages in the Arch package line, except for the missing packages listed
below. No duplicate or shadowing key chords were found in `config.h`. The
Alacritty Up/Down conflict was fixed.

`wpctl` is provided by the configured PipeWire stack; Polybar's PulseAudio
module uses `pipewire-pulse`. `brightnessctl` device availability is checked
by the module, and the launch script selects battery/backlight configuration
from sysfs. The screenshot bindings create and save to
`~/Pictures/screenshots`; the wallpaper paths use
`~/Pictures/backgrounds` and tolerate an empty directory.

The MATE polkit agent path is
`/usr/lib/mate-polkit/polkit-mate-authentication-agent-1`. No manual
`gnome-keyring-daemon` launch or conflicting `setxkbmap` call is present.
Keyboard layout remains the system Xorg configuration. SDDM's launcher
redirects its output to `~/.cache/dwm-session.log` and enters through the same
`~/.xinitrc` used by `startx`.

The session cursor name is consistently `Bibata-Modern-Ice`, matching the
variant downloaded by the Bibata setup helper. The SDDM greeter runs as its
own account, however, so a cursor installed only in the user's `~/.icons` may
not be available to the login screen.

### Missing packages to add to `arch-setup/dwm-wattox.sh`

The install script was not changed. Add or confirm the following packages:

- `xorg-xrdb` — loads `~/.Xresources`.
- `xdg-utils` — provides `xdg-open` and `xdg-settings` used by Dunst and
  `webapp-launch`.
- `adwaita-fonts` — provides the configured `Adwaita Sans` GTK font if it is
  not already pulled in by the system.
- `papirus-icon-theme` — the configured Rofi icon theme.
- `i3lock` — enables the power-menu lock action; `betterlockscreen` is an
  alternative.
- `curl` (or `wget`) — optional icon downloads in `webapp-create`.
- `xdotool` — only needed if retaining/using the currently unbound
  `active-audio` helper.
- `lsof` and `psmisc` — `lsof` and `killall` used by the full Proton reset
  sweep (`killall` is supplied by `psmisc`).
- `dbus` — ensure `dbus-update-activation-environment` is available; startup
  logs an explicit warning if it is absent.

Already present in the package line: Polybar, `xorg-xprop`, `xorg-xrandr`,
NetworkManager/`nm-applet`, PipeWire/`pipewire-pulse`/WirePlumber, `wpctl`,
`brightnessctl`, Flameshot, Rofi, Dunst, clipmenu, `mate-polkit`, Firefox,
Meslo installation, Noto CJK, and Noto emoji.

## Suggested changes outside scope

- The Makefile installs `.xinitrc` with mode `0644`; `startx` expects an
  executable client script. Install it as `0755` (or chmod it) in the build
  install target. SDDM's external launcher has a `/bin/sh` fallback, but
  `startx` does not.
- If `Super+M` must be true EWMH fullscreen rather than monocle plus bar hide,
  update the custom `fullscreen()` implementation in `dwm.c`. Make its saved
  layout per-monitor if multi-monitor testing confirms the global state causes
  restoration issues.
- To match the greeter cursor, install Bibata system-wide or configure SDDM's
  cursor theme; the user's `~/.icons` install is not visible to the SDDM
  account.
- Redshift remains enabled at `0.0:0.0` as requested; change it to the user's
  coordinates when available.
- The selected `sddm-astronaut-theme` variant is `japanese_aesthetic`. Matching
  Polybar/Rofi/Dunst colors to that palette is an optional visual change; none
  was made.

## Manual test checklist after first SDDM login

- [ ] Confirm the session starts once and review `~/.cache/dwm-session.log`.
- [ ] Confirm the Polybar is visible on each connected monitor.
- [ ] Press `Super+M` and confirm the bar hides/restores with the monocle
      layout; separately test an application's true fullscreen video.
- [ ] Press `Super+Shift+B` and confirm the selected monitor's bar toggles.
- [ ] Verify `polybar-msg` responds for each bar (IPC is enabled on both).
- [ ] Test volume up/down/mute with PipeWire and check the Polybar audio module.
- [ ] Test brightness keys and confirm the detected backlight device changes.
- [ ] Take full and selection screenshots; confirm files land in
      `~/Pictures/screenshots`.
- [ ] Open Rofi, launch an app, and open the keybinding help; confirm tag
      bindings appear.
- [ ] Trigger an authorization prompt and confirm the MATE polkit agent shows.
- [ ] Copy several items, open clipmenu history, and paste one.
- [ ] Send a notification and verify Dunst display/history.
- [ ] Run `~/.config/polybar/launch.sh` again while dwm is running; confirm
      there is still only one bar per monitor. This tests launcher
      idempotence. `Super+Shift+Q` logs out rather than restarting dwm; for a
      session restart, log out and select dwm again, then recheck bar counts.

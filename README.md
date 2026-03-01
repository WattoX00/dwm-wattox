# My modified dwm

![DEMO2](assets_for_github/demo2.png)

This is my **HEAVILY MODIFIED** version of dwm. It is based on the original [dwm-titus](https://github.com/ChrisTitusTech/dwm-titus) dwm window manager just fine tuned for my preferances.

## Installation

See automated arch installation here: [ArchSetup](https://github.com/WattoX00/arch-setup)

![DEMO3](assets_for_github/demo3.png)

![DEMO1](assets_for_github/demo1.png)

## Configuration Location

All configuration files are available at:

```bash
~/.local/share/dwm-wattox
```

Make your changes inside that directory.

After modifying configs, recompile and install:

```bash
cd ~/.local/share/dwm-wattox
sudo make clean install
```

Then either:

- Reboot

OR

- Press `Win + Shift + Q` to exit to TTY and run:

```bash
startx
```

## Base Hotkeys (modifiable in config.c)

### General Commands

| Keybinding | Action |
|------------|--------|
| Win + /    | Show command list |
| Win + R    | Rofi menu |
| Win + X    | Open terminal |
| Win + E    | Thunar file manager |
| Win + N    | Todol |
| Win + U    | nvim |
| Win + B    | Open browser |
| Win + P    | Take screenshot |
| Win + M    | Toggle fullscreen |
| Win + Q    | Close active window |


## Workspaces / Tags

| Keybinding | Action |
|------------|--------|
| Win + 1-9  | Switch between tags/workspaces |

## Window Navigation

| Keybinding | Action |
|------------|--------|
| Win + K    | Focus next window |
| Win + J    | Focus previous window |

## Window Ordering / Layout Control

Use the following:

Win + H
Win + L
Win + I
Win + O
Win + T
Win + F

## Notes

- `Win` = Super key
- All keybindings are defined in `config.c`

Enjoy 🚀


## Packages

<details>
<summary>Click to expand</summary>

🎨 Theming & Appearance

* [feh](https://feh.finalrewind.org/) - Wallpaper management
* [nwg-look](https://github.com/nwg-piotr/nwg-look) - GTK theme configuration
* [picom](https://github.com/yshui/picom) - Compositor (transparency, animations)
* [polybar](https://github.com/polybar/polybar) - Status bar
* [redshift](https://wiki.archlinux.org/title/Redshift) - Screen color temperature adjustment

🖥 Terminal & Shell Workflow

* [Alacritty](https://github.com/alacritty/alacritty) - Terminal emulator
* [ttf-meslo-nerd](https://github.com/ryanoasis/nerd-fonts) - Nerd Font (Meslo) for terminal glyphs
* [fastfetch](https://github.com/fastfetch-cli/fastfetch) - System information display
* [eza](https://github.com/eza-community/eza) - Modern replacement for ls
* [zoxide](https://github.com/ajeetdsouza/zoxide) - Smarter cd command

🧠 Editor & Development Tools

* [neovim](https://neovim.io/) - Text editor
* [python-pipx](https://github.com/pypa/pipx) - Isolated Python application installs
* [git](https://git-scm.com/) - Version control
* [base-devel](https://archlinux.org/packages/core/any/base-devel/) - Essential development tools
* [unzip](https://infozip.sourceforge.net/UnZip.html) - Archive extraction

🔍 Launchers & Notifications

* [rofi](https://github.com/davatorium/rofi) - Application launcher
* [dunst](https://github.com/dunst-project/dunst) - Notification daemon
* [clipmenud](https://github.com/cdown/clipmenu) - Clipboard manager for rofi

📁 File Management

* [thunar](https://docs.xfce.org/xfce/thunar/start) - File manager
* thunar-archive-plugin - Archive integration for Thunar
* [tumbler](https://docs.xfce.org/xfce/tumbler/start) - Thumbnail support
* [gvfs](https://wiki.gnome.org/Projects/gvfs) - Virtual filesystem support

🔊 Audio & Media Utilities

* [PipeWire](https://pipewire.org/) - Audio server
* [pavucontrol](https://gitlab.freedesktop.org/pulseaudio/pavucontrol) - Audio control GUI

🌐 Networking & Internet

* [networkmanager](https://networkmanager.dev/) - Network management service
* [network-manager-applet](https://wiki.gnome.org/Projects/NetworkManager) - NetworkManager tray applet
* [firefox](https://www.firefox.com/en-US/) - Web browser

🔐 Session & System Utilities

* [mate-polkit](https://github.com/mate-desktop/mate-polkit) - PolicyKit authentication agent
* [gnome-keyring](https://wiki.gnome.org/Projects/GnomeKeyring) - Credential storage
* [xdg-user-dirs](https://www.freedesktop.org/wiki/Software/xdg-user-dirs/) - Standard user directories
* [xdg-desktop-portal-gtk](https://github.com/flatpak/xdg-desktop-portal-gtk) - Desktop portal backend for GTK

🖥 Xorg & Display

* [xorg-server](https://www.x.org/wiki/) - Xorg display server
* [xorg-xinit](https://www.x.org/wiki/) - Start X sessions
* [xorg-xprop](https://www.x.org/wiki/) - X window property utility
* [libx11](https://gitlab.freedesktop.org/xorg/lib/libx11) - X11 client library
* [libxinerama](https://gitlab.freedesktop.org/xorg/lib/libxinerama) - Multi-monitor support library
* [libxft](https://gitlab.freedesktop.org/xorg/lib/libxft) - Font rendering library
* [imlib2](https://docs.enlightenment.org/api/imlib2/html/) - Image loading/rendering library

💡 Hardware & System Controls

* [brightnessctl](https://github.com/Hummer12007/brightnessctl) - Brightness control utility

🧰 Productivity & Utilities

* [flameshot](https://flameshot.org/) - Screenshot utility
* [xclip](https://github.com/astrand/xclip) - Clipboard utility
* [flatpak](https://flatpak.org/) - Flatpak application support
* [todol](https://github.com/WattoX00/todol) - Simple todo list app

🔤 Fonts

* [noto-fonts-emoji](https://fonts.google.com/noto/specimen/Noto+Emoji) - Emoji font support
* [noto-fonts-cjk](https://archlinux.org/packages/extra/any/noto-fonts/) - CJK (Chinese, Japanese, Korean) font support

🗂 User Configuration

* Custom dotfiles and configuration folders
* Custom background setup

</details>

## ❤️ Support

If this project saved you time, taught you something, or made your day a little easier,
you can support its development here:

👉 **[Buy me a coffee via PayPal](https://www.paypal.com/paypalme/wattox)**

Your support helps keep the project:
- Actively maintained
- Continuously improved
- Free and open source

Thanks for being part of the community 🤝

## 📄 License

This project is licensed under the **MIT License**.  
See the [LICENSE](LICENSE) file for full details.

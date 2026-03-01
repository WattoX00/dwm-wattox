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
| Win + 1–9  | Switch between tags/workspaces |

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

* feh – Wallpaper management
* nwg-look – GTK theme configuration
* picom – Compositor (transparency, animations)
* polybar – Status bar
* redshift – Screen color temperature adjustment

🖥 Terminal & Shell Workflow

* Alacritty – Terminal emulator
* ttf-meslo-nerd – Nerd Font (Meslo) for terminal glyphs
* fastfetch – System information display
* eza – Modern replacement for ls
* zoxide – Smarter cd command

🧠 Editor & Development Tools

* neovim (nvim) – Text editor
* python-pipx – Isolated Python application installs
* git – Version control
* base-devel – Essential development tools
* unzip – Archive extraction

🔍 Launchers & Notifications

* rofi – Application launcher
* dunst – Notification daemon
* clipmenud – Clipboard manager for rofi

📁 File Management

* thunar – File manager
* thunar-archive-plugin – Archive integration for Thunar
* tumbler – Thumbnail support
* gvfs – Virtual filesystem support

🔊 Audio & Media Utilities

* PipeWire – Audio server
* pavucontrol – Audio control GUI

🌐 Networking & Internet

* networkmanager – Network management service
* network-manager-applet – NetworkManager tray applet
* firefox – Web browser

🔐 Session & System Utilities

* mate-polkit – PolicyKit authentication agent
* gnome-keyring – Credential storage
* xdg-user-dirs – Standard user directories
* xdg-desktop-portal-gtk – Desktop portal backend for GTK

🖥 Xorg & Display

* xorg-server – Xorg display server
* xorg-xinit – Start X sessions
* xorg-xprop – X window property utility
* libx11 – X11 client library
* libxinerama – Multi-monitor support library
* libxft – Font rendering library
* imlib2 – Image loading/rendering library

💡 Hardware & System Controls

* brightnessctl – Brightness control utility

🧰 Productivity & Utilities

* flameshot – Screenshot utility
* xclip – Clipboard utility
* flatpak – Flatpak application support

🔤 Fonts

* noto-fonts-emoji – Emoji font support
* noto-fonts-cjk – CJK (Chinese, Japanese, Korean) font support

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

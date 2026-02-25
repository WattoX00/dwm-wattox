# My modified dwm

![DEMO2](assets_for_github/demo2.png)

This is my **HEAVILY MODIFIED** version of dwm. It is based on the original [dwm-titus](https://github.com/ChrisTitusTech/dwm-titus) dwm window manager just fine tuned for my preferances.

## Installation

See installationhere: [ArchSetup](https://github.com/WattoX00/arch-setup)

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

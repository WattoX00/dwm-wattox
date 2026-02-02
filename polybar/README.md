# Polybar Collection

My personal collection. Trying to make some nice themes, and show how great [Polybar](https://github.com/polybar/polybar) is. I'll keep updating the collection, and maybe create some custom scripts so you and I can have a better experience with this thing. I also recommend you to check this [adi1090x Polybar Collection](https://github.com/adi1090x/polybar-themes), has some great themes, so if you don't like my collection, you can just check the other one. Also the reason why I'm doing this is because I want you to have more options and ideas to build your own theme.

Read this README with attention.

## Getting Started

### Prerequisites

First of all, install Polybar:

[Compiling Polybar](https://github.com/polybar/polybar/wiki/Compiling)

By default the font used is `JetBrainsMono` (you can change it in the **fonts.ini** file), you can download and install from [NerdFonts](https://www.nerdfonts.com/font-downloads):

Also you'll need [MaterialIcons](https://github.com/google/material-design-icons) and [Feather](https://feathericons.com/).
You can move both **MaterialIcons** and **feather** inside **fonts** to **$HOME/.fonts/** and run:

```bash
$HOME
-> fc-cache -fv
```

or just search how to install fonts!

### Cloning

Now you need to clone the repo in the \$HOME directory (because the path inside the files points to **$HOME/polybar-collection**):

```bash
$HOME
-> git clone --depth 1 https://github.com/Murzchnvok/polybar-collection
```

or clone to other directory and create a symlink of the folder in the \$HOME directory:

```bash
$HOME/Projects
-> git clone --depth 1 https://github.com/Murzchnvok/polybar-collection

$HOME
-> ln -s $HOME/Projects/polybar-collection $HOME/polybar-collection
```

### Running

BSPwm

```bash
$HOME/polybar-collection/launch.sh
```

I3wm

```bash
exec_always --no-startup-id $HOME/polybar-collection/launch.sh
```

Remember to keep updated:

```bash
$HOME
-> cd $HOME/polybar-collection && git pull
```

## Few changes

Now we only have one file **modules.ini** to change the modules that we like to use. I believe that's a better way to configure our Polybar themes:

```ini
modules-left = date wallz nft tor weather bspwm i3
modules-center = mpd
modules-right = pulseaudio
```

## You might be interested

- [Rofi Collection](https://github.com/Murzchnvok/rofi-collection)
- [Wallpaper Collection](https://drive.google.com/drive/folders/1o1qjRgkJtnF_8uGB1z6MRsQUjWinHUsw?usp=sharing)
- [Pomotroid (pomodoro app)](https://github.com/Splode/pomotroid)
- [Todol](https://github.com/Wattox00/todol)

_Enjoy!_

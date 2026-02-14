#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# copy to clipboard ->  command | ccopy
alias ccopy='xclip -selection clipboard'

# git workflow boost (turn these off)
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'

PS1='[\u@\h \W]\$ '

# Run fastfetch on shell initialization
fastfetch

# Created by `pipx` on 2026-02-01 15:36:22
export PATH="$PATH:/home/wattox/.local/bin"

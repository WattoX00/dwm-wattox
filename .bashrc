#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# clipmenud setup
export CM_LAUNCHER="rofi"
export CM_HISTLENGTH=15

# command | coppy
alias ccopy='xclip -selection clipboard'

# git aliases
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'

# j insted of cd
eval "$(zoxide init bash --cmd j)"
alias cd="j"
alias ..="cd .."
alias p="pwd"

# eza for l commands
alias ls="eza --icons"
alias ll="eza -lh --icons"
alias la="eza -lha --icons"

alias rld='clear && fastfetch'

PS1='[\u@\h \W]\$ '

# Run fastfetch on shell initialization
fastfetch

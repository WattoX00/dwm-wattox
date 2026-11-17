#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# command | coppy
alias ccopy='xclip -selection clipboard'

# User enviraments to run lazyvim as root
alias snvim='sudo -E nvim'

# git aliases
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'

# git history
alias gl='git --no-pager log --oneline'

# local commits not pushed
alias gll='git --no-pager log --oneline @{u}..HEAD'

# local commits + all diffs
alias glld='git --no-pager log -p @{u}..HEAD'

# j insted of cd
eval "$(zoxide init bash --cmd j)"
alias cd="j"
alias ..="cd .."
alias p="pwd"

# Clear clipboard history
alias cch='rm -f "$HOME/.cache/clipmenu"/clipmenu.*."$USER"/*'

#python virtual enviraments
alias pv="python -m venv .venv"
alias sv="source .venv/bin/activate"

# eza for l commands
alias ls='eza --icons=auto'
alias ll="eza -lh --icons=auto"
alias la="eza -lha --icons=auto"

alias rld='clear && fastfetch'

# bf for Bash File creation
# usage: bf filename

bf() {
  [[ "$1" != *.sh ]] && set -- "$1.sh"

  if [[ -e "$1" ]]; then
    echo "File already exists: $1"
    return 1
  fi

  echo "#!/bin/bash" >"$1"
  chmod +x "$1"

  echo "Created: $(realpath "$1")"
}

PS1='[\u@\h \W]\$ '

# Run fastfetch on shell initialization
fastfetch

eval "$(starship init bash)"

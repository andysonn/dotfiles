export ZSH="/Users/an/.oh-my-zsh"

# ZSH_THEME="philips"
ZSH_THEME="agnoster"

plugins=(
  git
  z
  zsh_reload
  brew
  tmux
  osx
  emoji
  docker
)

source $ZSH/oh-my-zsh.sh

if brew list | grep zsh-completions &>/dev/null; then
  fpath=(/usr/local/share/zsh-completions $fpath)
  autoload -Uz compinit && compinit
fi

if brew list | grep zsh-syntax-highlighting &>/dev/null; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if brew list | grep zsh-autosuggestions &>/dev/null; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

set -o vi

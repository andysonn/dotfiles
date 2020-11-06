export ZSH=$HOME/.oh-my-zsh
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

################################################################################
# oh-my-zsh
plugins=(
  git
  z
  zsh_reload
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
  brew
  tmux
  osx
  yarn
)

source $ZSH/oh-my-zsh.sh

# zsh-completions 包是用以增强zsh的补全功能, mac系统可不安装。
# 启用 zsh-completions
autoload -U compinit && compinit

HIST_STAMPS="yyyy-mm-dd"
################################################################################


################################################################################
# iterm shell - https://www.iterm2.com/documentation-shell-integration.html
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# set variables for iTerm2 status bar
iterm2_print_user_vars() {
  iterm2_set_user_var pwd $(pwd)
  iterm2_set_user_var nodeVersion $(node -v)
}
################################################################################


################################################################################
# zsh prompt - pure
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure
################################################################################


################################################################################
# hkokApp
alias build-app='cd ~/Work/hkokApp; npm run build; rsync -azvP ./dist/hkok_app/ ~/Work/hkok/public/hkok_app/; rsync -azvP ./dist/resources/views/home/ ~/Work/hkok/resources/views/home/; cd -;'

# hkokV2
alias build-v2='cd ~/Work/hkokV2; npm run build; rsync -azvP ./dist/v2/ ~/Work/hkok/public/v2/; rsync -azvP ./dist/resources/views/v2/ ~/Work/hkok/resources/views/v2/; cd -;'
################################################################################


################################################################################
# Other
set -o vi
set backspace=2
alias backup-brew='brew bundle dump --describe --force --file="$HOME/Documents/iProfile/config/brew/Brewfile"'
################################################################################

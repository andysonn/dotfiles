#!/usr/bin/env sh

# set current path const
ROOT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CONFIG_DIR="$ROOT_DIR/config"
SCRIPT_DIR="$ROOT_DIR/script"

# import tools function
source "$ROOT_DIR/command/tools.sh"

if [ -e $1 ]; then
  bash "$COMMAND" "$ROOT_DIR"
else
  echo "$1 is no defined command"
fi

install-all() {
  echo "Running install-mac.sh..."
}

# ssh config
install-ssh-config() {
  # 启动 ssh agent
  eval "$(ssh-agent -s)"
  # 将 SSH 私钥添加到 ssh-agent 并将密码短语(passphrase)存储在密钥链中
  # -K macOS 的密钥链
  ssh-add -K ~/.ssh/id_rsa

  FROM_FILES="$CONFIG_DIR/ssh/.*"
  TARGET_DIR=~/.ssh/

  log-section-start "Sym linking files from $FROM_FILES to $TARGET_DIR"
  symlink-files "$FROM_FILES" "$TARGET_DIR"
}

# home config files
install-home-config() {
  FROM_FILES="$CONFIG_DIR/home/.*"
  TARGET_DIR=~

  log-section-start "Sym linking files from $FROM_FILES to $TARGET_DIR"
  symlink-files "$FROM_FILES" "$TARGET_DIR"
}

# iTerm2 shell
install-iterm2-menubar() {
  log-section-start "Installing iTerm2 shell integration for fancy menubar"
  curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
}

# oh-my-zsh
install-oh-my-zsh() {
  log-section-start "Installing oh-my-zsh"

  if [ -d ~/.oh-my-zsh/ ]; then
    echo "Cleaning up ~/.oh-my-zsh/"
    rm -rf ~/.oh-my-zsh/
  fi

  RUNZSH=no

  KEEP_ZSHRC=yes

  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  echo "Installing zsh-completions"
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

  echo "Installing zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

  echo "Installing zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

  FROM_FILES="$CONFIG_DIR/oh-my-zsh/*"
  TARGET_DIR=~/.oh-my-zsh/custom/
  log-section-start "Sym linking files from $FROM_FILES to $TARGET_DIR"
  symlink-files "$FROM_FILES" "$TARGET_DIR"
}

# iprintf-vim
install-iprintf-vim() {
  # backup
  test -e ~/.vim -o -e ~/.vimrc -o -e ~/.vimrc.local -o -e ~/.vim.plugins \
    && tar -cf ~/vim_backup_$(date +%m%d%H%M%S).tar ~/.vim* &> /dev/null
  rm -rf ~/.vim* &> /dev/null

  git clone https://gitee.com/iprintf/vim ~/.iprintf-vim
  echo -e "set clipboard=unamed" >> ~/.iprintf-vim/config/.vimrc

  FROM_FILES=~/.iprintf-vim/config/.vim*
  TARGET_DIR=~/
  log-section-start "Sym linking files from $FROM_FILES to $TARGET_DIR"
  symlink-files "$FROM_FILES" "$TARGET_DIR"
}

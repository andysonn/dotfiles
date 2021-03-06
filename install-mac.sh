#!/usr/bin/env sh

# set current path const
ROOT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CONFIG_DIR="$ROOT_DIR/config"
SCRIPT_DIR="$ROOT_DIR/script"

# import tools function
source "$ROOT_DIR/command/tools.sh"

# ssh config
install_ssh_config() {
  log_section_start "Installing ssh config"

  if [ -f ~/.ssh/id_rsa ]; then
    # 启动 ssh agent
    eval "$(ssh-agent -s)"
    # 将 SSH 私钥添加到 ssh-agent 并将密码短语(passphrase)存储在密钥链中
    # -K macOS 的密钥链
    ssh-add -K ~/.ssh/id_rsa
  else
    echo "~/.ssh/id_rsa file no exists"
  fi

  TARGET_DIR=~/.ssh/

  if [ ! -d $TARGET_DIR ]; then
    mkdir $TARGET_DIR &> /dev/null
  fi
}

# iTerm2 shell
install_iterm2() {
  log_section_start "Installing iTerm2"

  curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
}

# oh-my-zsh
install_oh_my_zsh() {
  log_section_start "Installing oh-my-zsh"

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

  mkdir -p "$HOME/.zsh"
  git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

  # config
  FROM_FILES="$CONFIG_DIR/oh-my-zsh/*"
  TARGET_DIR=~/.oh-my-zsh/custom/

  log_section_start "Sym linking files from $FROM_FILES to $TARGET_DIR"
  symlink_files "$FROM_FILES" "$TARGET_DIR"
}

# oh-my-zsh
install_oh_my_wechat() {
  log_section_start "Installing oh-my-wechat"

  curl -o- -L https://omw.limingkai.cn/install.sh | bash -s
}

# iprintf-vim
install_iprintf_vim() {
  log_section_start "Installing iprintf vim"

  test -e ~/.vim -o -e ~/.vimrc -o -e ~/.vimrc.local -o -e ~/.vim.plugins \
    && tar -cf ~/vim-backup-$(date +%m%d%H%M%S).tar ~/.vim* &> /dev/null
  rm -rf ~/.vim* &> /dev/null

  git clone https://gitee.com/iprintf/vim ~/.iprintf-vim
  echo -e "\nset clipboard=unnamed" >> ~/.iprintf-vim/config/.vimrc

  FROM_FILES=~/.iprintf-vim/config/.vim*
  TARGET_DIR=~
  log_section_start "Sym linking files from $FROM_FILES to $TARGET_DIR"
  symlink_files "$FROM_FILES" "$TARGET_DIR"
}

install_mac() {
  log_section_start "Installing mac config"
  bash "$SCRIPT_DIR/mac.sh" "$ROOT_DIR"
}

install_brew() {
  log_section_start "Installing brew config"
  bash "$SCRIPT_DIR/brew.sh" "$ROOT_DIR"
}

install_mackup() {
  log_section_start "Installing mackup config"

  if command -v mackup >/dev/null 2>&1; then
    mackup backup
  else
    echo "no exists mackup"
  fi
}

install_all() {
  install_ssh_config
  install_iterm2
  install_oh_my_zsh
  install_oh_my_wechat
  install_iprintf_vim
  install_mac
  install_brew
  install_mackup
}

if [ "$(type -t "install_$1")" == function ]; then
  install_$1
else
  echo "$1 is no defined function"
fi

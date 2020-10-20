#!/bin/bash

set_git() {
  cp ./git-config/.gitconfig ~/.gitconfig
  cp ./git-config/config ~/.ssh/config
  cp ./git-config/id_rsa.pub ~/.ssh/id_rsa.pub
}

set_vim() {
  # 备份
  test -e ~/.vim -o -e ~/.vimrc -o -e ~/.vimrc.local -o -e ~/.vim.plugins \
    && tar -cf ~/vim_backup_$(date +%m%d%H%M%S).tar ~/.vim* &> /dev/null

  # 删除
  rm -rf ~/.vim* &> /dev/null

  # 覆盖
  cp -rf ./vim-config/.vim* ~/
}

set_inputrc() {
  cp ./inputrc ~/.inputrc
}

set_tmux() {
  cp ./.tmux.conf ~/.tmux.conf
}

set_zsh() {
  cp ./.zshrc ~/.zshrc
}

set_ideavimrc() {
  cp ./.ideavimrc ~/.ideavimrc
}

set_clipboard() {
  # vim
  echo -e "#系统剪切板\nset clipboard=unamed" >> ~/.vimrc

  # ideavimrc
  echo -e "#系统剪切板\nset clipboard+=unnamed" >> ~/.ideavimrc
}

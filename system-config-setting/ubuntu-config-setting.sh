#!/bin/bash

cfg_dir=$(pwd)

apt_source_update () {
  sudo cp ./ubuntu-sources.list /etc/apt/sources.list
  sudo apt update
}

set_vi () {
  echo "set -o vi" >> ~/.bashrc
  echo "PS1='\[\e[32;1m\]\u \w \n\[\e[0m\]'" >> ~/.bashrc
  cp ./.inputrc ~/.inputrc
}

sogoupinyin_install () {
  sudo dpkg -i sogoupinyin_2.2.0.0108_amd64.deb
  sudo apt install -f -y
}

git_install() {
  sudo apt install git -y
  cp ./git-config/.gitconfig ~/.gitconfig
  cp ./git-config/id_rsa.pub ~/.ssh/id_rsa.pub
  cp ./git-config/config ~/.ssh/config
}

vim_install() {
  sudo apt remove vim-common -y
  sudo apt install vim -y
  git clone https://gitee.com/iprintf/vim ~/vim
  cd ~/vim
  # ./linux_install.sh
  # 备份
  test -e ~/.vim -o -e ~/.vimrc -o -e ~/.vimrc.local -o -e ~/.vim.plugins \
    && tar -cf ~/vim_backup_$(date +%m%d%H%M%S).tar ~/.vim* &> /dev/null
  # 删除
  rm -rf ~/.vim* &> /dev/null
  # 覆盖
  cp -rf ./config/.vim* ~/
  cd $cfg_dir
}

tmux_install() {
  sudo apt install tmux -y
  cp ./.tmux.conf ~/.tmux.conf
}

docker_install(){
  sudo dpkg -i docker-ce_18.06.1_ce_2.2.rc2-0_ubuntu_amd64.deb
  sudo groupadd docker
  sudo gpasswd -a ${USER} docker
  sudo service docker restart
  newgrp - docker
}

apt_source_update
set_vi
tmux_install
git_install
vim_install
sogoupinyin_install
# docker_install

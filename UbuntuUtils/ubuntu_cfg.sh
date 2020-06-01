#!/bin/bash

cfg_dir=$(pwd)

apt_source_update () {
    sudo cp ./sources.list /etc/apt/sources.list
    sudo apt update
}

set_vi () {
    echo "set -o vi" >> ~/.bashrc
    echo "PS1='\[\e[32;1m\]\u \w \n\[\e[0m\]'" >> ~/.bashrc
    cp ./inputrc ~/.inputrc
}

sogoupinyin_install () {
    sudo dpkg -i sogoupinyin_2.2.0.0108_amd64.deb
    sudo apt install -f -y
}

git_install() {
    sudo apt install git -y
    cp ./gitconfig/gitconfig ~/.gitconfig
    touch ~/.ssh/id_rsa
    cp ./gitconfig/id_rsa.pub ~/.ssh/id_rsa.pub
    cp ./gitconfig/config ~/.ssh/config
}

vim_install() {
    sudo apt remove vim-common -y
    sudo apt install vim -y
    git clone https://gitee.com/iprintf/vim ~/vim
    cd ~/vim
    ./linux_install.sh
    cd $cfg_dir
}

tmux_install() {
    sudo apt install tmux -y
    cp ./tmux.conf ~/.tmux.conf
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
# vim_install
# sogoupinyin_install
# docker_install

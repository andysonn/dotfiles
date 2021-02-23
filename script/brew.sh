#!/usr/bin/env sh

echo ""
echo "#######################################"
echo "# Installing various programs from brew"
echo "#######################################"
echo ""

brew -v >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

ROOT_DIR=$1

# set it as default shell
chsh -s /bin/zsh

brew install mas

if [ -f ~/Dropbox/Mackup/.backupfile/Brewfile ]; then
  brew bundle --file="~/Dropbox/Mackup/.backupfile/Brewfile"
fi

#!/usr/bin/env sh

# set current path const
ROOT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CONFIG_DIR="$ROOT_DIR/config"
SCRIPT_DIR="$ROOT_DIR/script"

# import tools function
source "$ROOT_DIR/command/tools.sh"

# oh-my-zsh
install_oh_my_zsh() {
  log_section_start "Installing oh-my-zsh"

  # config
  FROM_FILES="$CONFIG_DIR/oh-my-zsh/*"
  TARGET_DIR=~/.oh-my-zsh/custom/
  log_section_start "Sym linking files from $FROM_FILES to $TARGET_DIR"
  symlink_files "$FROM_FILES" "$TARGET_DIR"
}


if [ "$(type -t "install_$1")" == function ]; then
  install_$1
else
  echo "$1 is no defined function"
fi

#!/usr/bin/env sh

# set current path const
ROOT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CONFIG_DIR="$ROOT_DIR/config"
SCRIPT_DIR="$ROOT_DIR/script"

# import tools function
source "$ROOT_DIR/command/tools.sh"

# oh-my-zsh
install_test() {
  log_section_start "Installing test"

  FROM_FILE="$CONFIG_DIR/iterm2/iProfiles.json"
  TARGET_FILE=~/Library/Application\ Support/iTerm2/DynamicProfiles/iProfiles.json

  log_section_start "Sym linking from $FROM_FILE to $TARGET_FILE"
  symlink "$FROM_FILE" "$TARGET_FILE"
}


if [ "$(type -t "install_$1")" == function ]; then
  install_$1
else
  echo "$1 is no defined function"
fi

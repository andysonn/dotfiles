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
}


if [ "$(type -t "install_$1")" == function ]; then
  install_$1
else
  echo "$1 is no defined function"
fi

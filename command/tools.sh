#!/bin/bash

function symlink-files() {
  for FILE in $1
  do
    if [ -f "$FILE" ]; then
      echo "Processing $FILE file"
      FILE_NAME=$(basename -- "$FILE")

      if [ -L "$2/$FILE_NAME" ]; then
        echo "found old $2/$FILE_NAME - removing ..."
        rm "$2/$FILE_NAME"
      fi

      echo "linking $FILE -> $2/$FILE_NAME"
      ln -s "$FILE" "$2/$FILE_NAME"
      echo ""
    fi
  done
}

function symlink() {
  ln -s "$1" "$2";
}

log-section-start() {
  echo ""
  echo ""
  echo "-> $1"
  echo ""
}

function brew-install-or-upgrade {
  if brew ls --versions "$1" >/dev/null; then
    HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade "$1"
  else
    HOMEBREW_NO_AUTO_UPDATE=1 brew install "$1"
  fi
}

#!/usr/bin/env bash

if [ "$(uname -s)" == "Darwin" ]
then
  # Check for Homebrew
  if test ! $(which brew)
  then
    echo "Installing Homebrew for you."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew installed!"
  fi

  # Check for Brewfile
  if test ../Brewfile
  then
    if [ "$CI" = "true" ]; then
      echo "CI environment detected, running brew bundle automatically"
      cd .. && brew bundle
      echo "brew bundle completed!"
    else
      echo "Brewfile detected, would you like to run brew bundle now?(y/n)"
      read -n 1 action

      case "$action" in
        y )
          cd .. && brew bundle
          echo "brew bundle completed!";;
        * )
          echo "brew bundle aborted!";;
      esac
    fi
  fi
fi

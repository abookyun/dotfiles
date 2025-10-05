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
      SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
      BREWFILE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
      cd "$BREWFILE_DIR"
      # Create CI Brewfile without mas commands
      grep -v '^mas ' Brewfile > Brewfile.ci
      brew bundle --file=Brewfile.ci
      rm Brewfile.ci
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

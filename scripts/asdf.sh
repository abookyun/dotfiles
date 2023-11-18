#!/usr/bin/env bash

echo 'setting up asdf'

if [ -f ~/.tool-versions ]
then
  plugins=$(asdf plugin list)
  installed=$(asdf list)
  for tool in $(cut -d " " -f 1 ~/.tool-versions);
  do
    [[ ! $plugins =~ $tool ]] && asdf plugin add $tool
    [[ ! $installed =~ $tool ]] && asdf install $tool
  done
fi

echo 'asdf setup complete'

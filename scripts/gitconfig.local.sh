#!/usr/bin/env bash

setup_gitconfig () {
  if ! [ -f git/config.local ]
  then
    echo 'setup gitconfig.local'

    if [ "$(uname -s)" == "Darwin" ]; then git_credential='osxkeychain'; else git_credential='cache'; fi

    echo '- What is your github author name?'
    read -e git_authorname
    echo '- What is your github author email?'
    read -e git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" git/config.local.example > git/config.local

    echo 'git/config.local has been created'
  fi
}

if ! [ -f git/config.local ]
then
  echo 'git/config.local not found, do you want to create?(y/n)'
  read -n 1 action
  echo ''

  case "$action" in
    y )
      setup_gitconfig;;
    * )
      echo 'User aborted';;
  esac
fi

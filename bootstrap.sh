#!/usr/bin/env bash


set -e

echo ''


info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}


link_mackup () {
  info 'linking mackup.cfg'
  ln -s ~/dotfiles/.mackup.cfg ~/.mackup.cfg
  echo ' Mackup config link to ~/.mackup.cfg'
}

link_mackup


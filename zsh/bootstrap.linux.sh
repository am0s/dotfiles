#!/usr/bin/env bash
set -e

# Install some necessary packages for the rest of the system to work
if [ ! dpkg -s curl 2>/dev/null 1>/dev/null ]; then
  printf "  [ \033[00;34m..\033[0m ] Installing curl, needed for zsh installation\n"
  sudo apt-get install curl
else
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] curl is installed\n"
fi


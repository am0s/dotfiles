#!/usr/bin/env bash
set -e

# Install some necessary packages for the rest of the system to work
if [ -not $(dpkg -s curl 2&>1 1>/dev/null) ]; then
  printf "  [ \033[00;34m..\033[0m ] Installing curl, needed for zsh installation"
  sudo apt-get install curl
fi


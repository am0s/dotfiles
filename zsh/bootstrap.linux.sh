#!/usr/bin/env bash
set -e

UPDATE_APT=0
INSTALL_CURL=0
INSTALL_SOCAT=0

# Install some necessary packages for the rest of the system to work
if ! dpkg -s curl 2>/dev/null 1>/dev/null; then
  printf "  [ \033[00;34m..\033[0m ] curl is missing, needed for zsh installation\n"
  INSTALL_CURL=1
  UPDATE_APT=1
else
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] curl is installed\n"
fi

if ! which socat >/dev/null; then
  if ! dpkg -s socat 2>/dev/null 1>/dev/null; then
    printf "  [ \033[00;34m..\033[0m ] socat is missing, needed for ssh-agent forwarding\n"
    INSTALL_SOCAT=1
    UPDATE_APT=1
  else
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] socat is installed\n"
  fi
else
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] socat is installed\n"
fi

if [ $UPDATE_APT -eq 1 ]; then
  printf "  [ \033[00;34m..\033[0m ] Preparing apt for installation\n"
  sudo apt-get update
fi

if [ $INSTALL_CURL -eq 1 ]; then
  printf "  [ \033[00;34m..\033[0m ] Installing curl, needed for zsh installation\n"
  sudo apt-get install -yq curl
fi
if [ $INSTALL_SOCAT -eq 1 ]; then
  printf "  [ \033[00;34m..\033[0m ] Installing socat, needed for zsh installation\n"
  sudo apt-get install -yq socat
fi

#!/usr/bin/env bash
#if ! [ -e $HOME/.oh-my-zsh/ ]; then
#    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
#fi

source $(dirname ..)/script/common

#if ! dpkg -l fzy >/dev/null 2>/dev/null; then
#    install_it=
#
#    while true; do
#      user "fzy not found: do you want to install it? [y]es, [n]o:"
#      read -n 1 action
#
#      case "$action" in
#        y|yes )
#          install_it=true
#          break
#          ;;
#        n|no )
#          break
#          ;;
#        * )
#          ;;
#       esac
#    done
#
#    if [ "$install_it" == "true" ]; then
#        info "installing fzy\n"
#        sudo apt-get update -y && sudo apt-get install -y fzy
#        success "fzy installed"
#    fi
#else
#    success "fzy installed"
#fi

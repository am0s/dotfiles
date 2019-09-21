#!/usr/bin/env bash
#if ! [ -e $HOME/.oh-my-zsh/ ]; then
#    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
#fi

source $(dirname ..)/script/common

if ! dpkg -l fzy >/dev/null; then
    info "fzy not found, installing\n"
    sudo apt-get update -y && sudo apt-get install -y fzy
    success "fzy installed"
else
    success "fzy installed"
fi

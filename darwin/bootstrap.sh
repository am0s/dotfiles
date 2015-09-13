#!/usr/bin/env bash
# handles installation, updates, things like that. Run it periodically
# to make sure you're on the latest and greatest.
export ZSH=$HOME/.dotfiles

# Set OS X defaults
$ZSH/osx/set-defaults.sh

# Upgrade homebrew
brew update

# Install homebrew packages
$ZSH/homebrew/install.sh 2>&1


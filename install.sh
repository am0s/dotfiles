#!/usr/bin/env bash
# Bootstrap docker container on first run (or when recreated)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Swap to a ssh based url
git remote set-url origin git@github.com:am0s/dotfiles.git

# Force email for this repo
git config --local user.email jborsodi@gmail.com

# Check if dotfiles have been properly bootstrapped and installed
if [[ ! -d $HOME/.dotfiles_root ]]; then
    echo "No dotfiles have been installed"
    # Ask if interactive tty
    if [[ -t 0 ]]; then
        echo -n "Do you wish to install them now? [Y/n] "
        while read input
        do
            case $input in
                no|N|n)
                    break
                    ;;
                yes|Y|y)
                    echo "Bootstrapping dotfiles"
                    $DIR/script/bootstrap
                    $DIR/script/install
                    break
                    ;;
                *)
                    echo -n "Do you wish to install them now? [Y/n] "
                    ;;
            esac
        done
    else
        echo "Bootstrapping dotfiles (non-interactive mode)"
        $DIR/script/bootstrap
        $DIR/script/install
    fi
fi

# Symlink the .bootstraprc file from the common home folder
# This is a non-git file which is shared among docker installs
# and is included on bash startup
if [[ ! -f ~/.bootstraprc && -f $HOME/.home-common/.bootstraprc ]]; then
    ln -s $HOME/.home-common/.bootstraprc $HOME/.bootstraprc
fi

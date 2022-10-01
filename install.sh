#!/usr/bin/env bash
# Bootstrap docker container on first run (or when recreated)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

(cd $DIR && \
    # Swap to a ssh based url
    git remote set-url origin git@github.com:am0s/dotfiles.git && \
    # Force email for this repo
    git config --local user.email jborsodi@gmail.com
)

INSTALL_DOTFILES=0
NO_DOTFILES=0

while getopts "hf" OPTION
do
   case $OPTION in
       h)
         # if -h, print help function and exit
         echo "Dotfiles install script"
         echo
         echo "Options:"
         echo " -f  Force (re)install"
         echo " -h  Help"
         exit -1
         ;;
       f)
         INSTALL_DOTFILES=1
         ;;
       ?)
         echo "ERROR: unknown options!! ABORT!!"
         echo "Add -h option to see help"
         exit -1
         ;;
     esac
done

if [[ ! -d $HOME/.dotfiles_root ]]; then
    INSTALL_DOTFILES=1
    NO_DOTFILES=1
fi

# Check if dotfiles have been properly bootstrapped and installed
if [ $INSTALL_DOTFILES -eq 1 ]; then
    if [ $NO_DOTFILES -eq 1 ]; then
        echo "No dotfiles have been installed"
    else
        echo "Re-installing dotfiles"
    fi
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

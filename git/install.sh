#!/usr/bin/env bash
set -e

quote () { 
    local quoted=${1//\'/\'\\\'\'};
    printf "'%s'" "$quoted"
}

GITCONF=~/.dotfiles_root/git/gitconfig
if which git >/dev/null; then
    # Finds all git config entries which are missing and inserts them
    git config -z -f $GITCONF -l --name-only | while read -d $'\0' config_name; do
        if ! git config --global --get "$config_name" >/dev/null; then
            git config -z -f $GITCONF --get-all "$config_name" | while read -d $'\0' config_value; do
                config_value=$(quote "$config_value")
                # Run git through bash to fix quoting hell
                bash -c "git config --global \"$config_name\" $config_value"
            done
        fi
    done

    # Check if git config is correct
    if [[ -t 0 ]]; then
        if ! git config --global --get user.name >/dev/null; then
            echo "No user name has been set in git config, please supply one"
            FULL_NAME=`getent passwd $USER | cut -d":" -f5 | cut -d"," -f1`
            read -e -p "Name: " -i "$FULL_NAME" git_name
            if [[ -n $git_name ]]; then
                git config --global user.name $git_name
            else
                echo "Skipping setting git user name"
            fi
        fi
        if ! git config --global --get user.email >/dev/null; then
            echo "No user email has been set in git config, please supply one"
            EMAIL=""
            read -e -p "E-mail: " -i "$EMAIL" git_email
            if [[ -n $git_email ]]; then
                git config --global user.email $git_email
            else
                echo "Skipping setting git email"
            fi
        fi
    fi

fi

# Transfer new enviroment variabels to the running zsh
# This makes it possible to login from multiple ssh session to the same tmux session
if [ -n "$TMUX" ]; then
    function refresh_env {
        sshauth=$(tmux show-environment | grep "^SSH_AUTH_SOCK")
        if [ $sshauth ]; then
            export $sshauth
        fi
        display=$(tmux show-environment | grep "^DISPLAY")
        if [ $display ]; then
            export $display
        fi
    }
else
    function refresh_env { }
fi

[[ -z $preexec_functions ]] && preexec_functions=()
preexec_functions=($preexec_functions refresh_env)

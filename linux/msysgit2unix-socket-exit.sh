#!/bin/sh
PID_FILE="$1"
SSH_AUTH_SOCK="$2"
SSH_AUTH_DIR="$3"
[ -s "$PID_FILE" ] && pkill -F "$PID_FILE"
rm -f "$PID_FILE" "$SSH_AUTH_SOCK"
[ -d "$SSH_AUTH_DIR" ] && rmdir "$SSH_AUTH_DIR"

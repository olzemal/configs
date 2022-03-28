#!/bin/bash
# shellcheck disable=SC2128

actions=("logout\nrestart\nshutdown")
action=$(echo -e "$actions" | dmenu)
case "$action" in
  logout)
    killall dwm
    ;;
  restart)
    SUDO_ASKPASS="$HOME/.scripts/dmenu_sudo.sh" sudo -A systemctl reboot
    ;;
  shutdown)
    SUDO_ASKPASS="$HOME/.scripts/dmenu_sudo.sh" sudo -A systemctl poweroff
    ;;
esac


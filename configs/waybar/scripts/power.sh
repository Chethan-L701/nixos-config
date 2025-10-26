#!/usr/bin/env bash

case $1 in
    --poweroff)
        kitten quick-access-terminal -o edge=bottom -o lines=5 -- $HOME/.config/waybar/scripts/power-options.sh --poweroff
        ;;
    --reboot)
        kitten quick-access-terminal -o edge=bottom -o lines=5 -- $HOME/.config/waybar/scripts/power-options.sh --reboot
        ;;
    --logout)
        kitten quick-access-terminal -o edge=bottom -o lines=5 -- $HOME/.config/waybar/scripts/power-options.sh --logout
        ;;
    --suspend)
        kitten quick-access-terminal -o edge=bottom -o lines=5 -- $HOME/.config/waybar/scripts/power-options.sh --suspend
        ;;
    --hibernate)
        kitten quick-access-terminal -o edge=bottom -o lines=5 -- $HOME/.config/waybar/scripts/power-options.sh --hibernate
        ;;
    --lock)
        hyprlock
        ;;
esac

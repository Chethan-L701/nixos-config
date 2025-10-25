key=$1

if [ "$key" == "--logout" ]; then
    selection=$(printf "yes\nno" | fzf --prompt='do you want to logout?')

    if [ "$selection" == "yes" ]; then
        if [ "$DESKTOP_SESSION" == "niri" ]; then
            niri msg action quit
        elif [ "$DESKTOP_SESSION" == "hyprland-uwsm" ]; then
            hyprctl dispatch exit
        fi
    fi
elif [ "$key" == "--poweroff" ]; then
    selection=$(printf "yes\nno" | fzf --prompt='do you want to poweroff?')

    if [ "$selection" == "yes" ]; then
        systemctl poweroff --now
    fi
elif [ "$key" == "--reboot" ]; then
    selection=$(printf "yes\nno" | fzf --prompt='do you want to reboot?')

    if [ "$selection" == "yes" ]; then
        systemctl reboot --now
    fi
fi

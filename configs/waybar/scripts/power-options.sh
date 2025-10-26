key=$1

if [ "$key" == "--logout" ]; then
    selection=$(printf "yes\nno" | fzf --prompt='do you want to logout?')

    if [ "$selection" == "yes" ]; then
        if [ "$DESKTOP_SESSION" == "niri" ]; then
            niri msg action quit
        elif [ "$DESKTOP_SESSION" == "hyprland-uwsm" ]; then
            uwsm stop
        fi
    fi

elif [ "$key" == "--poweroff" ]; then
    selection=$(printf "yes\nno" | fzf --prompt='do you want to poweroff?')

    if [ "$selection" == "yes" ]; then
        systemctl poweroff --now
    fi

elif [ "$key" == "--suspend" ]; then
    selection=$(printf "yes\nno" | fzf --prompt='do you want to suspend(auto hibernate after some time)[S3 -> S4]?')

    if [ "$selection" == "yes" ]; then
        systemctl suspend-then-hibernate
    fi

elif [ "$key" == "--hibernate" ]; then
    selection=$(printf "yes\nno" | fzf --prompt='do you want the pc on hibernate mode[S4]?')

    if [ "$selection" == "yes" ]; then
        systemctl hibernate
    fi
elif [ "$key" == "--reboot" ]; then
    selection=$(printf "yes\nno" | fzf --prompt='do you want to reboot?')

    if [ "$selection" == "yes" ]; then
        systemctl reboot --now
    fi
fi

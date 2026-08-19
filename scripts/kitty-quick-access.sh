options="htop\nyazi\nbluetui\nopen-file\nwallpapers\ntmux-sessions\nswitch-windows\nplayerctl\nnushell\nfish\nactions\n"

selection=$(printf $options | fzf --color='fg:7,pointer:14')

if [ "$selection" == "htop" ]; then

    htop

elif [ "$selection" == "fish" ]; then

    fish

elif [ "$selection" == "nushell" ]; then

    nu

elif [ "$selection" == "yazi" ]; then

    yazi

elif [ "$selection" == "bluetui" ]; then

    bluetui

elif [ "$selection" == "open-file" ]; then

    file=$(fish -c "fd -u -t f | fzf")
    if [ -n "$file" ]; then
        if [ "$DESKTOP_SESSION" == "niri" ]; then
            niri msg action spawn -- xdg-open "$file"
        elif [[ "$DESKTOP_SESSION" == "hyprland-uwsm" || "$DESKTOP_SESSION" == "hyprland" ]]; then
            hyprctl dispatch "hl.dsp.exec_cmd('xdg-open $file')"
        fi
    fi

elif [ "$selection" == "wallpapers" ]; then
    /etc/nixos/scripts/set-wallpaper.sh
elif [ "$selection" == "tmux-sessions" ]; then
    tmux_session=$(tmux ls)
    if [ "$?" -eq 0 ]; then
        tmux_session=$(tmux ls | fzf --prompt 'select the tmux session to start...' --color='fg:7,pointer:14')
        tmux_session=$(echo "$tmux_session" | awk -F':' '{print $1}')
        if [ -n "$tmux_session" ]; then
            if [ "$DESKTOP_SESSION" == "niri" ]; then
                niri msg action spawn -- kitty -e fish -c "tmux attach -t $tmux_session"
            elif [[ "$DESKTOP_SESSION" == "hyprland-uwsm" || "$DESKTOP_SESSION" == "hyprland" ]]; then
                hyprctl dispatch  "hl.dsp.exec_cmd(\"kitty -e fish -c tmux attach -t $tmux_session\")"
            fi
        fi
    else
        read
    fi
elif [ "$selection" == "switch-windows" ]; then
    /etc/nixos/scripts/window-picker.sh
elif [ "$selection" == "playerctl" ]; then

    actions="play-pause\nstop\nnext\nprevious\nshuffle\nloop"
    action=$(fish -c "printf $actions | fzf")
    if [ -n "$action" ]; then
        playerctl $action
    fi
elif [ "$selection" == "actions" ]; then 
    /etc/nixos/scripts/actions.sh

fi


options="htop\nyazi\nbluetui\nopen-file\nwallpapers\ntmux-sessions\nswitch-windows\nplayerctl"

selection=$(printf $options | fzf)

if [ "$selection" == "htop" ]; then

    htop

elif [ "$selection" == "yazi" ]; then

    yazi

elif [ "$selection" == "bluetui" ]; then

    bluetui

elif [ "$selection" == "open-file" ]; then

    file=$(fd -u -t f | fzf)
    if [ -n "$file" ]; then
        nvim $file
    fi

elif [ "$selection" == "wallpapers" ]; then

    wallpaper_dir="/etc/nixos/wallpapers"
    wallpaper_sel=$(cd $wallpaper_dir && \
        fd -t f -e jpg -e png -e jpeg |fzf \
            --preview='kitten icat --clear --transfer-mode=memory --place=80x40@95x0 --align center --stdin=no {} > /dev/tty' \
            --preview-window "right,50%,border-left")
    swww img --transition-type wave "$wallpaper_dir/$wallpaper_sel"

elif [ "$selection" == "tmux-sessions" ]; then

    tmux_session=$(tmux ls | fzf --prompt "select the tmux session to start...")
    tmux_session=$(echo "$tmux_session" | awk -F':' '{print $1}')
    if [ -n "$tmux_session" ]; then
        if [ "$DESKTOP_SESSION" == "niri" ]; then
            niri msg action spawn -- kitty -e fish -c "tmux attach -t $tmux_session"
        elif [ "$DESKTOP_SESSION" == "hyprland-uwsm" ]; then
            hyprctl dispatch exec -- kitty -e fish -c "tmux attach -t $tmux_session"
        fi
    fi
elif [ "$selection" == "switch-windows" ]; then
    /etc/nixos/scripts/window-picker.sh
elif [ "$selection" == "playerctl" ]; then

    actions="play-pause\nstop\nnext\nprevious\nshuffle\nloop"
    action=$(printf $actions | fzf)
    if [ -n "$action" ]; then
        playerctl $action
    fi

fi


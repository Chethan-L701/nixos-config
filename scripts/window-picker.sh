if [ "$DESKTOP_SESSION" == "niri" ]; then
    listwindows | fzf | awk -F':' '{print $1}' | awk -F' ' '{print $3}' | xargs niri msg action focus-window --id 
elif [ "$DESKTOP_SESSION" == "hyprland-uwsm" ]; then
    hyprctl dispatch focuswindow address:$(listwindows | fzf | awk -F':' '{print $1}' | awk -F' ' '{print $3}')
fi

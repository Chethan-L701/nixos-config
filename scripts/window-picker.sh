if [ "$DESKTOP_SESSION" == "niri" ]; then
    listwindows | fzf | awk -F':' '{print $1}' | awk -F' ' '{print $3}' | xargs niri msg action focus-window --id 
elif [[ "$DESKTOP_SESSION" == "hyprland-uwsm" || "$DESKTOP_SESSION" == "hyprland" ]]; then
    hyprctl dispatch "hl.dsp.focus({ window = 'address:$(listwindows | fish -c fzf | awk -F':' '{print $1}' | awk -F' ' '{print $3}')' })"
fi

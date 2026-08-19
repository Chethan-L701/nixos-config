options="logout\nvolume\nbrightness\n"

selection=$(printf $options | fzf --color='fg:7,pointer:14')

if [ "$selection" == "logout" ]; then 
    if [[ "$DESKTOP_SESSION" == "niri" ]]; then
        niri msg action quit
    elif [ "$DESKTOP_SESSION" == "hyprland" || "$DESKTOP_SESSION" == "hyprland-uwsm" ]; then
        hyprctl dispatch exit
    fi
elif [ "$selection" == "volume" ]; then
    current=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F':' '{print $2}')
    current=$(echo "$current * 100" | bc | xargs printf "%.0f" )
    read -p "set volume(current: $current): " new_volume
    if [ "$new_volume" -lt "0" ]; then 
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 0
    elif [ "$new_volume" -gt "150" ]; then
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 1.5
    else
        new_volume=$(echo "scale=2;$new_volume / 100" | bc | xargs printf "%.2f")
        wpctl set-volume @DEFAULT_AUDIO_SINK@ $new_volume
    fi
fi

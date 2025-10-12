waybar_top_id=$(ps -ax | rg -e 'waybar -c (.*)horizontal' | rg -v rg | awk -F' ' '{print $1}')


if [ -z "$waybar_top_id" ]; then
    if [ "$DESKTOP_SESSION" == "niri" ]; then
        waybar -c $HOME/.config/waybar/configs/bar-horizontal &
    elif [ "$DESKTOP_SESSION" == "hyprland-uwsm" ]; then
        waybar -c $HOME/.config/waybar/configs/bar-horizontal-hypr &
    fi
else
    kill 9 $waybar_top_id
fi


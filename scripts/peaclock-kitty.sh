if [ "$DESKTOP_SESSION" == "hyprland-uwsm" ]; then
    notify-send "not implemented for hyprland"
elif [ "$DESKTOP_SESSION" == "niri" ]; then
    echo "Detected user desktop session niri."

    peaclock_id=$(niri msg -j windows | jq '.[] | select(.app_id=="peaclock") | .id' | sed "s/\"//g")
    if [ -n "$peaclock_id" ]; then
        echo "peaclock window is open"
        echo "closing the window"

        niri msg action close-window --id $peaclock_id

        if [ "$?" == 0 ]; then
            echo "successfully closed the peaclock window"
        else
            echo "Failed to close the peaclock window"
        fi
    else
        echo "peaclock window is not active"
        echo "launching a new peaclock window"
        niri msg action spawn -- kitty --app-id peaclock peaclock
    fi
fi

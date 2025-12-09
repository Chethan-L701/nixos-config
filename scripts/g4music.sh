if [ "$DESKTOP_SESSION" == "hyprland-uwsm" ]; then
    echo "Detected user desktop session hyprland-uwsm."

    g4music_address=$(hyprctl -j clients | jq '.[] | select(.class=="com.github.neithern.g4music") | .address' | sed "s/\"//g")
    if [ -n "$g4music_address" ]; then
        echo "g4misic window found "
        echo "closing the window"

        hyprctl dispatch closewindow "address:$g4music_address"

        if [ "$?" == 0 ]; then
            echo "successfully closed the the g4music window"
        else
            echo "Failed to close the g4music window"
        fi
    else
        echo "g4music window is not active"
        echo "launching a new g4music window"
        uwsm app -- g4music &> /dev/null
    fi

elif [ "$DESKTOP_SESSION" == "niri" ]; then
    echo "Detected user desktop session niri."

    g4music_id=$(niri msg -j windows | jq '.[] | select(.app_id=="com.github.neithern.g4music") | .id' | sed "s/\"//g")
    if [ -n "$g4music_id" ]; then
        echo "g4misic window found"
        echo "closing the window"

        niri msg action close-window --id $g4music_id

        if [ "$?" == 0 ]; then
            echo "successfully closed the the g4music window"
        else
            echo "Failed to close the g4music window"
        fi
    else
        echo "g4music window is not active"
        echo "launching a new g4music window"
        niri msg action spawn -- g4music
    fi
fi

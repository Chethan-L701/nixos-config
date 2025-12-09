if [ "$DESKTOP_SESSION" == "hyprland-uwsm" ]; then
    echo "Detected user desktop session hyprland-uwsm."

    nmgui_pid=$(hyprctl -j clients | jq '.[] | select(.class=="com.network.manager") | .pid')
    if [ -n "$nmgui_pid" ]; then
        echo "nmgui window found with pid:$nmgui_pid"
        echo "killing the nmgui window with pid:$nmgui_pid"

        kill $nmgui_pid

        if [ "$?" == 0 ]; then
            echo "successfully closed the the nmgui window"
        else
            echo "Failed to close the nmgui window"
        fi
    else
        echo "nmgui window is not active"
        echo "launching a new nmgui window"
        uwsm app -- nmgui &> /dev/null &
    fi

elif [ "$DESKTOP_SESSION" == "niri" ]; then
    echo "Detected user desktop session niri."

    nmgui_pid=$(niri msg -j windows | jq '.[] | select(.app_id=="com.network.manager") | .pid')
    if [ -n "$nmgui_pid" ]; then
        echo "nmgui window found with pid:$nmgui_pid"
        echo "killing the nmgui window with pid:$nmgui_pid"

        kill $nmgui_pid

        if [ "$?" == 0 ]; then
            echo "successfully closed the the nmgui window"
        else
            echo "Failed to close the nmgui window"
        fi
    else
        echo "nmgui window is not active"
        echo "launching a new nmgui window"
        niri msg action spawn -- nmgui &> /dev/null
    fi
fi

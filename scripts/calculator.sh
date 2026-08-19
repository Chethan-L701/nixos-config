#!/usr/bin/env bash

calculator_pid=$(pgrep -xf gnome-calculator)

if [ "$DESKTOP_SESSION" == "niri" ]; then
    if [ -n "$calculator_pid" ]; then
        window_id=$(niri msg --json windows | jq ".[] | select(.pid==$calculator_pid) | .id")
        window_workspace_id=$(niri msg --json windows | jq ".[] | select(.pid==$calculator_pid) | .workspace_id")
        focused_workspace_id=$(niri msg --json workspaces | jq ".[] | select(.is_focused==true) | .id")
        focused_workspace_idx=$(niri msg --json workspaces | jq ".[] | select(.is_focused==true) | .idx")

        if [ "$window_workspace_id" == "$focused_workspace_id" ]; then
            kill 9 $calculator_pid &> /dev/null
        else
            niri msg action move-window-to-workspace --window-id $window_id $focused_workspace_idx 
            niri msg action focus-window --id $window_id
        fi

    else 
        gnome-calculator &
    fi
elif [[ "$DESKTOP_SESSION" == "hyprland" || "$DESKTOP_SESSION" == "hyprland-uswm" ]]; then
    if [ -n "$calculator_pid" ]; then
        read -r address workspace <<<"$(
            hyprctl clients -j |
                jq -r ".[] | select(.pid == $calculator_pid) | \"\(.address) \(.workspace.id)\""
            )"

            current_workspace=$(hyprctl activeworkspace -j | jq -r '.id')

            if [ "$workspace" = "$current_workspace" ]; then
                kill -9 "$calculator_pid" >/dev/null 2>&1
            else
                hyprctl dispatch "hl.dsp.window.move({ workspace = '$current_workspace', window = 'address:$address'})"
            fi
        else
            gnome-calculator &
    fi
fi

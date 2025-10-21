#!/usr/bin/env bash


calculator_pid=$(ps -ax | rg -e 'gnome-calculator' | rg -v rg | awk -F' ' '{print $1}')

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

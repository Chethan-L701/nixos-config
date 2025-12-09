window_address=$(hyprctl -j activewindow | jq -r '.address')
hyprctl dispatch pin "address:$window_address"

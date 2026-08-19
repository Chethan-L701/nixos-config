window_address=$(hyprctl -j activewindow | jq -r '.address')
echo $window_address
hyprctl hl.dispatch.pin\("address:$window_address"\)

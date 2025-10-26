#!/usr/bin/env bash

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

playerctl status > /dev/null 2>&1
playerctl_status=$?
if [ $playerctl_status -ne 0 ]; then
    echo '{"text" : "", "class" : "hidden"}'
    exit 0
fi

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i=i+1))
done

# write cava config
config_file="/tmp/waybarbar_cava_config"
printf "
[general]
mode = normal
bars = 20

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7

[color]
gradient = 1
gradient_count = 2
gradient_color_1 = '#694dde'
gradient_color_2 = '#e64565'

" > $config_file

# read stdout from cava
cava -p $config_file | while read -r line; do
current_bar=$(echo $line | sed $dict)
echo "{\"text\" : \"$current_bar\", "class" : "cava" }"
done

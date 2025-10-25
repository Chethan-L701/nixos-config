#!/usr/bin/env bash

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i=i+1))
done

# write cava config
config_file="/tmp/waybarbar_cava_config"
echo "
[general]
bars = 26

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7

gradient = 2
gradient_color_1 = '#694dde'
gradient_color_2 = '#e64565'

" > $config_file

# read stdout from cava
cava -p $config_file | while read -r line; do
    echo $line | sed $dict
done

#!/usr/bin/env bash

action=$1
value=$2

if [ $action = 'up' ]; then
	brightnessctl s $value%+ > /dev/null
fi

if [ $action = 'down' ]; then 
	brightnessctl s $value%- > /dev/null
fi

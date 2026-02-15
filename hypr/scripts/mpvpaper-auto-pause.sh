#!/bin/bash

TARGET_MONITOR="HDMI-A-1"

while true; do

    if hyprctl clients | grep -q "class: sober"; then
        pkill -STOP -f "mpvpaper.*$TARGET_MONITOR"
    else
        pkill -CONT -f "mpvpaper.*$TARGET_MONITOR"
    fi

    sleep 1

done

#!/bin/bash

WALL=$(cat "$HOME/.cache/current_wallpaper" 2>/dev/null)

[ -z "$WALL" ] && exit
[ ! -f "$WALL" ] && exit

pkill mpvpaper 2>/dev/null

case "$WALL" in
    *.mp4|*.webm|*.mkv|*.gif)
        mpvpaper -o "loop no-audio" '*' "$WALL" &
        ;;
    *)
        swww img "$WALL" \
          --transition-type none
        ;;
esac

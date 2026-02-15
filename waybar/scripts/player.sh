#!/bin/bash

player_status=$(playerctl status 2>/dev/null)

if [[ "$player_status" != "Playing" && "$player_status" != "Paused" ]]; then
  echo ""
  exit
fi

artist=$(playerctl metadata artist)
title=$(playerctl metadata title)
position=$(playerctl position)
length=$(playerctl metadata mpris:length)

# converter pra segundos
length_sec=$((length / 1000000))
position_sec=${position%.*}

# barra de progresso (10 blocos)
bar_size=10
filled=$((position_sec * bar_size / length_sec))
empty=$((bar_size - filled))

bar="$(printf '▰%.0s' $(seq 1 $filled))$(printf '▱%.0s' $(seq 1 $empty))"

if [[ "$player_status" == "Playing" ]]; then
  icon=""
else
  icon=""
fi

echo "{\"text\":\"$icon  $artist - $title  $bar\",\"class\":\"music\"}"


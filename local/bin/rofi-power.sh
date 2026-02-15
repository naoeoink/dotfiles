#!/bin/bash

options="⏻ Desligar\n Reiniciar\n󰍃 Logout\n Bloquear"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu")

case "$chosen" in
  *Desligar)
    systemctl poweroff
    ;;
  *Reiniciar)
    systemctl reboot
    ;;
  *Logout)
    hyprctl dispatch exit
    ;;
  *Bloquear)
    hyprlock
    ;;
esac


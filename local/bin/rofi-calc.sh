#!/bin/bash

HIST="$HOME/.cache/rofi-calc-history"
mkdir -p "$(dirname "$HIST")"
touch "$HIST"

while true; do
    INPUT=$( (cat "$HIST"; echo "") | rofi -dmenu -p "Calculadora" )

    [ -z "$INPUT" ] && exit

    RESULT=$(echo "$INPUT" | bc -l 2>/dev/null)

    # se der erro, não salva
    if [ -z "$RESULT" ]; then
        notify-send "Calculadora" "Expressão inválida"
        continue
    fi

    echo "$INPUT = $RESULT" >> "$HIST"
done


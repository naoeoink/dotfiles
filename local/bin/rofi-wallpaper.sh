#!/bin/bash

WALLPAPER_DIR="$HOME/Wallpapers"
CACHE_DIR="$HOME/.cache/rofi-wallpapers"

mkdir -p "$CACHE_DIR"

# gera thumbnails se não existirem (só pra imagens)
for file in "$WALLPAPER_DIR"/*; do
    [ -f "$file" ] || continue

    thumb="$CACHE_DIR/$(basename "$file").png"

    if [ ! -f "$thumb" ]; then
        case "$file" in
            *.mp4|*.webm|*.mkv|*.mov)
                ffmpegthumbnailer -i "$file" -o "$thumb" -s 256 -q 5
                ;;
            *.gif)
                magick "$file[0]" -resize 256x256 "$thumb"
                ;;
            *)
                magick "$file" -resize 256x256 "$thumb"
                ;;
        esac
    fi
done


# cria lista com ícones
CHOICE=$(ls "$WALLPAPER_DIR" | while read -r file; do
    icon="$CACHE_DIR/$file.png"

    # se não existir thumbnail (ex: vídeo), usa ícone padrão
    if [ ! -f "$icon" ]; then
        icon="video-x-generic"
    fi

    echo -e "$file\0icon\x1f$icon"
done | rofi -dmenu -i -p "Wallpaper" -show-icons \
     -theme ~/.config/rofi/wallpaper-grid.rasi)

[ -z "$CHOICE" ] && exit


FULL_PATH="$WALLPAPER_DIR/$CHOICE"

echo "$FULL_PATH" > "$HOME/.cache/current_wallpaper"

# mata mpvpaper se tiver rodando
pkill mpvpaper 2>/dev/null

# detecta tipo
case "$FULL_PATH" in
    *.mp4|*.webm|*.mkv|*.gif)
        mpvpaper -o "loop no-audio" 'HDMI-A-1' "$FULL_PATH" &
        mpvpaper -o "loop no-audio" 'HDMI-A-2' "$FULL_PATH"
        ;;
    *)
        swww img "$FULL_PATH" \
          --transition-type any \
          --transition-fps 60 \
          --transition-duration 1
        ;;
esac

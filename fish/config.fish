if status is-interactive
# Commands to run in interactive sessions can go here
end

export PATH="$HOME/.local/bin:$PATH"

# set img (ls ~/.config/fastfetch/imagens/*.png | shuf -n 1)
# fastfetch --logo $img

starship init fish | source

fish_add_path /home/ink/.spicetify

fastfetch

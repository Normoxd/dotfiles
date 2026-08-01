#!/bin/bash

dp=$(< $HOME"/.config/hypr/assets/dp")

if [[ $dp == "off" ]]; then
	hyprctl dispatch dpms on
	notify-send "we are so back"
	notify-send -i ~/.config/hypr/assets/screenhppy.png "screen go" "Brrrrrrrrrrrrrrrrrrrr"
	echo "on" | cat > ~/.config/hypr/assets/dp
fi

if [[ $dp == "on" ]]; then
	hyprctl dispatch dpms off
	echo "off" | cat > ~/.config/hypr/assets/dp
fi

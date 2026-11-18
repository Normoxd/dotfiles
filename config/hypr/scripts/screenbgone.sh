#!/bin/bash

dp=$(< $HOME"/.config/hypr/assets/dp")

if [[ $dp == "off" ]]; then
	hyprctl dispatch 'hl.dsp.dpms({ action = "enable" })' & pw-play ~/.config/hypr/assets/switchon.mp3
	echo "on" | cat > ~/.config/hypr/assets/dp
fi

if [[ $dp == "on" ]]; then
	hyprctl dispatch 'hl.dsp.dpms({ action = "disable" })' & pw-play ~/.config/hypr/assets/switchoff.mp3
	echo "off" | cat > ~/.config/hypr/assets/dp
fi

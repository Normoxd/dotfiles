#!/bin/bash

HYPR="$HOME/.config/hypr"
FILE="$HYPR/hypridle.conf"
CAFF="$HYPR/hypridle.conf.caff"

if [ -f "$FILE" ]; then
    notify-send -i "$HYPR/assets/caffon.png" "Caffeinated!" &
    pw-play "$HYPR/assets/coffee-pour.mp3" &
    mv "$FILE" "$CAFF"
elif [ -f "$CAFF" ]; then
    notify-send -i "$HYPR/assets/caffoff.png" "Decaffeinated!" &
    pw-play "$HYPR/assets/glass-shattering.mp3" &
    mv "$CAFF" "$FILE"
else
    notify-send "Caffeine" "Error: Neither config file found!"
    exit 1
fi

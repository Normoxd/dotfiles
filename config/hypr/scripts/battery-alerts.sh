#!/bin/bash

ping10=false
ping20=false
plugged=false
firstrun=true
full=false
ASSETS="$HOME/.config/hypr/assets"
BATTERY="/sys/class/power_supply/BAT1"

if [[ ! -d "$BATTERY" ]]; then
    notify-send "/hypr/scripts/battery-alerts.sh" "No battery found (BAT1)\n\nTry changing it to BAT0 if you actually have one"
    exit 1
fi

while true; do
    batt_lvl=$(< "$BATTERY/capacity")
    b_status=$(< "$BATTERY/status")

   if [[ "$firstrun" == true ]]; then
        if [[ "$b_status" == "Charging" ]]; then
           plugged=true
       else
           plugged=false
        fi

       firstrun=false
   fi

    if [[ "$b_status" == "Discharging" ]]; then
        
        if [[ $plugged == true ]]; then
            pw-play "$ASSETS/power-unplug.oga"
            plugged=false
        fi
        
        if (( batt_lvl <= 5 )); then
             notify-send -u critical -i "$ASSETS/battery-000.png" "Critical Battery" "Level: $batt_lvl%"
             pw-play "$ASSETS/battery-caution.oga"
             sleep 2
        fi
             
        
        if (( batt_lvl <= 10 )) && [[ "$ping10" == false ]]; then
            notify-send -u critical -i "$ASSETS/battery-010.png" "Really Low Battery" "Level: $batt_lvl%"
            pw-play "$ASSETS/battery-caution.oga"
            ping10=true
            ping20=true
        fi

        if (( batt_lvl <= 20 )) && [[ "$ping20" == false ]]; then
            notify-send -i "$ASSETS/battery-020.png" "Low Battery" "Level: $batt_lvl%"
            pw-play "$ASSETS/battery-low.oga"
            ping20=true
        fi
        
        if [[ $full == true ]]; then
            full=false
        fi
    fi

    if [[ "$b_status" == "Charging" ]]; then
        if [[ $batt_lvl -gt 20 ]]; then
           ping10=false
           ping20=false
        fi
    fi
    sleep 2
done

#!/bin/bash
# this thing is inefficient af. Keep that in mind :3

below10=false
below20=false
full=false

while true; do
    b_level=$(cat /sys/class/power_supply/BAT1/capacity)
    b_status=$(cat /sys/class/power_supply/BAT1/status)
    
    if [[ "$b_status" == "Discharging" ]]; then

        if [[ $b_level -le 10 && "$below10" == false ]]; then
            notify-send -u critical -i ~/.config/hypr/assets/batterycritical.png "Ciwitical battury :3" "Lewul: $b_level%"
            paplay ~/.config/hypr/assets/battery-caution.oga
            full=false
            below20=true
            #below10=true   # uncomment this if you dont want this alert to repeat
        fi
        if [[ $b_level -le 20 && "$below20" == false ]]; then
            notify-send -i ~/.config/hypr/assets/batterylow.png "Louw Batttury" "Levwel: $b_level%"
            paplay ~/.config/hypr/assets/battery-low.oga
            full=false
            below20=true
            below10=false
        fi
    fi
    
    if [[ "$b_status" == "Charging" ]]; then
        if [[ "$b_level" == "100" && "$full" == false ]]; then
           notify-send -i ~/.config/hypr/assets/batteryfull.png "bwaterry ful" "twime to unpugg!"
           paplay ~/.config/hypr/assets/battery-full.oga
           full=true
           below10=false
           below20=false
        fi
    fi
   
    #Debug section---------------     Uncomment when you need it okay? ❍⩊❍ this dam script is too fragile
    #echo $b_level $b_status 
    #echo 10-? = $below10
    #echo 20-? = $below20
    #echo 100? = $full
    #echo 
    #----------------------------
    
    sleep 4
    continue
done

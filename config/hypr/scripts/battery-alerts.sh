#!/bin/bash
# Held together with hopes and prayers. Don't touch anything 🙏

notified10=false
notified20=false
full=false
plugged=false
firstrun=true
ASSETS="$HOME/.config/hypr/assets"
BATTERY="/sys/class/power_supply/BAT1"

if [[ ! -d "$BATTERY" ]]; then
    notify-send "/hypr/scripts/battery-alerts.sh" "No battery found (BAT1)\n\nTry changing it to BAT0 if you actually have one"
    exit 1
fi

while true; do
    b_level=$(< "$BATTERY/capacity")
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
            paplay "$ASSETS/power-unplug.oga"
            plugged=false
        fi
        
        if (( b_level <= 10 )) && [[ "$notified10" == false ]]; then
            notify-send -u critical -i "$ASSETS/batterycritical.png" "Ciwitical battury :3" "Lewul: $b_level%"
            paplay "$ASSETS/battery-caution.oga"
            #notified10=true  #(uncomment this if you dont want this to repeat)
            notified20=true
        fi

        if (( b_level <= 20 )) && [[ "$notified20" == false ]]; then
            notify-send -i "$ASSETS/batterylow.png" "Louw Batttury" "Levwel: $b_level%"
            paplay "$ASSETS/battery-low.oga"
            notified20=true
        fi
        
        if [[ $full == true ]]; then
            full=false
        fi
    fi

    if [[ "$b_status" == "Full" && "$full" == false ]]; then
        notify-send -i "$ASSETS/batteryfull.png" "bwaterry ful" "twime to unpugg!"
        paplay "$ASSETS/battery-full.oga"
        full=true
    fi
    
    if [[ "$b_status" == "Charging" ]]; then
    
        if [[ "$plugged" == false ]]; then
           paplay "$ASSETS/power-plug.oga"
           plugged=true
        fi
       
        if [[ $b_level -gt 20 ]]; then
           notified10=false
           notified20=false
        fi
    fi

    #Debug section---------------     Uncomment when you need it okay? ❍⩊❍ this dam script is too fragile
    #echo $b_level $b_status 
    #echo 10-? = $notified10
    #echo 20-? = $notified20
    #echo 100? = $full
    #echo plugged? = $plugged
    #echo first run? = $firstrun
    #echo 
    #----------------------------
    
    sleep 2
done

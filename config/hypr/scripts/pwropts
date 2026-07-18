#!/bin/bash

options="Lock\nShutdown\nRestart\nLogout\nHibernate\nSleep"

chosen=$(echo -e "$options" | wofi --dmenu --width 240 --height 300)

case "$chosen" in
    Lock)
    	paplay ~/.config/hypr/assets/android-lock.mp3
    	hyprlock
    	;;
    Shutdown)
	paplay ~/.config/hypr/assets/leapster-explorer-outro.mp3
        systemctl poweroff
        ;;
    Restart)
        paplay ~/.config/hypr/assets/leapster-explorer-outro.mp3
	systemctl reboot
        ;;
    Logout)
    	paplay ~/.config/hypr/assets/leapster-explorer-outro.mp3
        hyprctl dispatch exit
        ;;
    Hibernate)
	paplay ~/.config/hypr/assets/leapster-explorer-outro.mp3
        systemctl hibernate
        ;;
    Sleep) 
	paplay ~/.config/hypr/assets/leapster-explorer-outro.mp3
        systemctl suspend
        ;;
esac

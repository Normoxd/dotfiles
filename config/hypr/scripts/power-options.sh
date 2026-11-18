#!/bin/bash

options="Lock\nShutdown\nRestart\nLogout\nHibernate\nSleep"

chosen=$(echo -e "$options" | wofi --dmenu --width 240 --height 300)

case "$chosen" in
    Lock)
    	bash ~/.config/hypr/scripts/lock.sh
    	;;
    Shutdown)
        systemctl poweroff
        ;;
    Restart)
	systemctl reboot
        ;;
    Logout)
        hyprctl dispatch 'hl.dsp.exit()'
        ;;
    Hibernate)
        systemctl hibernate
        ;;
    Sleep) 
        systemctl suspend
        ;;
esac

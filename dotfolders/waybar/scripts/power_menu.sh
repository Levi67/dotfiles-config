#!/bin/bash

# Example using wofi (you can also use rofi or any launcher)
choice=$(echo -e " Lock\n⏾ Suspend\n Reboot\n Shutdown\n🚪 Logout" | wofi --dmenu --width=200 --height=300 --cache-file=/dev/null)

case "$choice" in
    " Lock")     hyprlock ;;
    "⏾ Suspend")  systemctl suspend ;;
    " Reboot")   systemctl reboot ;;
    " Shutdown") systemctl poweroff ;;
    "🚪 Logout")   hyprctl dispatch exit ;;
esac

#!/bin/bash
if zenity --question --text="Exit Hyprland?"; then
  hyprctl dispatch exit
fi

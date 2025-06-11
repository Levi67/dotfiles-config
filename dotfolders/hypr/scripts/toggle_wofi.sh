#!/bin/bash

# Check if Wofi is running and get its window ID (Hyprland client address)
WIN_ID=$(hyprctl clients | grep -i 'wofi' | head -n1 | awk '{print $1}')

if [[ -n "$WIN_ID" ]]; then
  # If running, focus the window
  hyprctl dispatch focuswindow address:$WIN_ID
else
  # If not running, launch Wofi
  wofi --show drun &
fi

#!/bin/bash

monitors=("HDMI-A-1" "DP-1" "DP-2")

# Define your workspace sets here:
# Button 1 -> workspaces 1,2,3
workspaces1=(1 2 3)

# Button 2 -> workspaces 4,5,6
workspaces2=(4 5 6)

# Button 3 -> workspaces 7,8,9
workspaces3=(7 8 9)

function switch_workspaces {
  local -n wspaces=$1  # pass array name as reference

  for i in "${!monitors[@]}"; do
    local mon=${monitors[$i]}
    local ws=${wspaces[$i]}

    echo "Switching monitor $mon (index $i) to workspace $ws"

    # Focus the monitor by index
    hyprctl dispatch focusmonitor "$i"
    #sleep 0.1

    # Switch to the workspace on that monitor
    hyprctl dispatch workspace "$ws"
    #sleep 0.1
  done
}

case "$1" in
  1) switch_workspaces workspaces1 ;;
  2) switch_workspaces workspaces2 ;;
  3) switch_workspaces workspaces3 ;;
  *) echo "Usage: $0 {1|2|3}" ;;
esac

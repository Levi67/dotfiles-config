#!/bin/bash

group=$1

# Use the group number as the label (1, 2, or 3)
label="$group"

# Define expected workspaces per group
case "$group" in
  1) expected=("1" "2" "3") ;;
  2) expected=("4" "5" "6") ;;
  3) expected=("7" "8" "9") ;;
  *) echo '{"text": "'"$label"'"}'; exit 0 ;;
esac

# Get current active workspaces for each monitor
mapfile -t active < <(hyprctl monitors -j | jq -r '.[].activeWorkspace.id')

# Compare expected vs actual
match=true
for i in "${!expected[@]}"; do
  if [[ "${active[i]}" != "${expected[i]}" ]]; then
    match=false
    break
  fi
done

# Output JSON
if $match; then
  echo "{\"text\": \"$label\", \"class\": \"active\"}"
else
  echo "{\"text\": \"$label\"}"
fi

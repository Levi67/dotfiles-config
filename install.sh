#!/bin/bash

# Path to your dotfiles "root"
DOTFILES_DIR="$HOME/Documents/dotfiles-config/dotfolders"

CONFIG_FOLDERS=(
  cava
  easyeffects
  fish
  fontconfig
  goverlay
  hypr
  input-remapper-2
  JetBrains
  kitty
  MangoHud
  neofetch
  nautilus
  nvim
  solaar
  swaync
  waybar
  waypaper
  wofi
)

echo "Creating symlinks to ~/.config/ from $DOTFILES_DIR"

for folder in "${CONFIG_FOLDERS[@]}"; do
  ln -sf "$DOTFILES_DIR/$folder" "$HOME/.config/$folder"
  echo "Linked: $folder"
done

echo "✅ All symlinks created!"

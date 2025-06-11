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

# Rainbow colors
colors=('\033[0;31m' '\033[0;33m' '\033[1;33m' '\033[0;32m' '\033[0;34m' '\033[0;35m' '\033[0;36m')
RESET='\033[0m'

echo
echo -e "${colors[0]}==${colors[1]}= ${colors[2]}DOTFILES ${colors[3]}INSTALLER ${colors[4]}==${colors[5]}=${colors[6]}=${RESET}"
echo

echo -e "${colors[6]}Linking configs from:${RESET} $DOTFILES_DIR"
echo

for folder in "${CONFIG_FOLDERS[@]}"; do
  ln -sf "$DOTFILES_DIR/$folder" "$HOME/.config/$folder"
  echo -e "${colors[3]}[+]:${RESET} Linked $folder"
done

# Read Firefox profile path from config file
CONFIG_FILE="./config.json"
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo -e "${colors[0]}Error:${RESET} Firefox config file $CONFIG_FILE not found!"
  exit 1
fi

FIREFOX_PROFILE_DIR=$(jq -r '.firefox_profile_path' "$CONFIG_FILE")
DOTFILES_CHROME_DIR="$DOTFILES_DIR/chrome"

if [[ ! -d "$FIREFOX_PROFILE_DIR" ]]; then
  echo -e "${colors[0]}Error:${RESET} Firefox profile directory $FIREFOX_PROFILE_DIR does not exist!"
  exit 1
fi

if [ -d "$FIREFOX_PROFILE_DIR/chrome" ] || [ -L "$FIREFOX_PROFILE_DIR/chrome" ]; then
  echo -e "${colors[1]}Backing up existing Firefox chrome folder to chrome.backup${RESET}"
  mv "$FIREFOX_PROFILE_DIR/chrome" "$FIREFOX_PROFILE_DIR/chrome.backup"
fi

ln -sfn "$DOTFILES_CHROME_DIR" "$FIREFOX_PROFILE_DIR/chrome"
echo -e "${colors[2]}[+]:${RESET} Linked Firefox chrome folder"

# DONE ASCII Art at the end
echo
echo -e "${colors[0]}  ____   ___  _   _ _____ ${RESET}"
echo -e "${colors[1]} |  _ \ / _ \| \ | | ____|${RESET}"
echo -e "${colors[2]} | | | | | | |  \| |  _|  ${RESET}"
echo -e "${colors[3]} | |_| | |_| | |\  | |___ ${RESET}"
echo -e "${colors[4]} |____/ \___/|_| \_|_____|${RESET}"
echo
echo -e "${colors[5]} ✅ DONE — All symlinks created successfully! ${RESET}"

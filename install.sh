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
  TARGET="$HOME/.config/$folder"
  SOURCE="$DOTFILES_DIR/$folder"

  if [[ -e "$TARGET" && ! -L "$TARGET" ]]; then
    BACKUP="$TARGET.backup.$(date +%s)"
    mv "$TARGET" "$BACKUP"
    echo -e "${colors[1]}🔸 Backed up $TARGET → $BACKUP${RESET}"
  fi

  ln -sfn "$SOURCE" "$TARGET"
  echo -e "${colors[3]}[+]:${RESET} Linked $folder"
done

# DONE ASCII Art at the end
echo
echo -e "${colors[0]}  ____   ___  _   _ _____ ${RESET}"
echo -e "${colors[1]} |  _ \\ / _ \\| \\ | | ____|${RESET}"
echo -e "${colors[2]} | | | | | | |  \\| |  _|  ${RESET}"
echo -e "${colors[3]} | |_| | |_| | |\\  | |___ ${RESET}"
echo -e "${colors[4]} |____/ \\___/|_| \\_|_____|${RESET}"
echo
echo -e "${colors[5]} ✅ DONE — All symlinks created successfully! ${RESET}"

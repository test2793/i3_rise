#!/bin/bash
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Run script with sudo! Example: sudo ./install.sh" >&2
    exit 1
fi

REAL_USER=${SUDO_USER:-$USER}
USER_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)
pacman -Syu --noconfirm git polybar picom dunst feh rofi alacritty gnome-screenshot maim xclip libpulse dex xss-lock i3lock xorg-setxkbmap xxkb ttf-terminus-nerd ttf-nerd-fonts-symbols

TEMP_DIR="/tmp/i3_rise"
rm -rf "$TEMP_DIR"
sudo -u "$REAL_USER" git clone https://github.com/test2793/i3_rise.git "$TEMP_DIR"

sudo -u "$REAL_USER" mkdir -p "$USER_HOME/.config" "$USER_HOME/BG" "$USER_HOME/Pictures"

sudo -u "$REAL_USER" cp -r "$TEMP_DIR/files/i3" "$USER_HOME/.config/"
sudo -u "$REAL_USER" cp -r "$TEMP_DIR/files/polybar" "$USER_HOME/.config/"

sudo -u "$REAL_USER" cp -r "$TEMP_DIR/files/BG/"* "$USER_HOME/BG/"

rm -rf "$TEMP_DIR"
sudo -u "$REAL_USER" fc-cache -fv

echo "Done! The rice has been successfully installed. Please restart your session (Super + Shift + E)."

#!/bin/sh

swww-daemon & 

# Mettre une image en fond (prendre une image aléatoire à chaque démarrage)
RANDOM_WALLPAPER=$(find ~/Pictures/Wallpaper/ -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)
swww img "$RANDOM_WALLPAPER" &

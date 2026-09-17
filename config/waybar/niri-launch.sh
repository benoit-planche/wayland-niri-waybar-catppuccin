#!/bin/sh

killall waybar 2>/dev/null
waybar -c "$HOME/.config/waybar/niri-config" -s "$HOME/.config/waybar/style.css" &
~/.config/waybar/wallpaper-launch.sh

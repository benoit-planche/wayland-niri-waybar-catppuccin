#!/bin/bash
set -euo pipefail

# Ce script affiche une liste de "bulles" pour chaque application ouverte sur le workspace actuel
# avec la bulle focusée en surbrillance. 
# Il est destiné à être utilisé avec un module custom dans Waybar.

# Obtenir les fenêtres ouvertes en JSON
windows_json=$(niri msg -j windows)
focused_id=$(niri msg -j focused-window | jq -r '.id')
workspace_id=$(niri msg -j focused-window | jq -r '.workspace_id')

# Construire la liste des bulles
output=""
mapfile -t windows <<< "$(echo "$windows_json" | jq -c ".[] | select(.workspace_id == $workspace_id)")"
for win in "${windows[@]}"; do
    id=$(echo "$win" | jq -r '.id')
    
    # Tous les icônes sont des cercles pleins
    icon="●"

    # Appliquer style focus ou normal
    if [ "$id" = "$focused_id" ]; then
        output+="<span foreground='purple'>$icon</span> "
    else
        output+="<span foreground='gray'>$icon</span> "
    fi

done

# Sortie JSON pour Waybar
jq -n --arg text "$output" '{"text": $text}' | tr -d '\n'

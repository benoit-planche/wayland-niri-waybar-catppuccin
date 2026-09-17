#!/bin/bash

# Ce script récupère le nom court de l'application de la fenêtre actuellement focalisée dans niri
# avec la première lettre en majuscule

# Exécution de la commande niri et extraction du champ app_id
app_id=$(niri msg --json focused-window | jq -r '.app_id')

# Fonction pour mettre la première lettre en majuscule
capitalize() {
    local string="$1"
    printf "%s%s" "$(echo "${string:0:1}" | tr '[:lower:]' '[:upper:]')" "$(echo "${string:1}")"
}

# Traitement du nom pour obtenir une version simplifiée
case "$app_id" in
    "org.gnome."*)
        # Pour toutes les applications GNOME, enlever le préfixe org.gnome.
        app_name=$(echo "${app_id#org.gnome.}" | tr '[:upper:]' '[:lower:]')
        ;;
    *"-browser")
        # Pour les navigateurs (comme chrome-browser)
        app_name=$(echo "${app_id%-browser}" | tr '[:upper:]' '[:lower:]')
        ;;
    *"."*)
        # Pour les autres applications avec un point, prendre la dernière partie
        app_name=$(echo "${app_id##*.}" | tr '[:upper:]' '[:lower:]')
        ;;
    *)
        # Pour les autres applications, retourner tel quel
        app_name=$(echo "$app_id" | tr '[:upper:]' '[:lower:]')
        ;;
esac

# Si app_name est "null", définir comme "Wofi"
[ "$app_name" = "null" ] && app_name="wofi"

# Mettre la première lettre en majuscule et afficher
echo " $(capitalize "$app_name")"

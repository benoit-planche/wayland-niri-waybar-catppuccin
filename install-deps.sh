#!/usr/bin/env bash
# Installe les paquets et thèmes nécessaires (Arch + AUR).
set -euo pipefail

if command -v paru >/dev/null 2>&1; then
  AUR=paru
elif command -v yay >/dev/null 2>&1; then
  AUR=yay
else
  echo "Erreur: installe paru ou yay (helper AUR) puis relance ce script." >&2
  exit 1
fi

echo "==> Helper AUR: $AUR"
echo "==> Installation des paquets..."

PKGS=(
  niri
  waybar
  wofi
  fuzzel
  dunst
  swaylock
  swww
  xwayland-satellite
  brightnessctl
  wireplumber
  bluez
  bluez-utils
  nwg-look
  papirus-icon-theme
  catppuccin-gtk-theme-macchiato
  catppuccin-cursors-mocha
)

"$AUR" -S --needed --noconfirm "${PKGS[@]}"

echo
echo "==> Dépendances installées."
echo "    Lance ensuite: ./install.sh"
echo "    Puis connecte-toi à une session niri."

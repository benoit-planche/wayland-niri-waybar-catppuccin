#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="${HOME}/.config-backup-wayland-$(date +%Y%m%d-%H%M%S)"

backup_if_exists() {
  local target="$1"
  if [[ -e "$target" ]]; then
    mkdir -p "$BACKUP_DIR"
    local rel="${target#"$HOME"/}"
    mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
    mv "$target" "$BACKUP_DIR/$rel"
    echo "Backup: $target -> $BACKUP_DIR/$rel"
  fi
}

install_dir() {
  local src="$1"
  local dest="$2"
  backup_if_exists "$dest"
  mkdir -p "$(dirname "$dest")"
  cp -a "$src" "$dest"
  echo "Installed: $dest"
}

echo "==> Installing Wayland / niri / Catppuccin configs"

install_dir "$ROOT/config/niri" "$HOME/.config/niri"
install_dir "$ROOT/config/waybar" "$HOME/.config/waybar"
install_dir "$ROOT/config/wofi" "$HOME/.config/wofi"
install_dir "$ROOT/config/fuzzel" "$HOME/.config/fuzzel"
install_dir "$ROOT/config/dunst" "$HOME/.config/dunst"
install_dir "$ROOT/config/swaylock" "$HOME/.config/swaylock"
install_dir "$ROOT/config/gtk-3.0" "$HOME/.config/gtk-3.0"
# gtk-4.0 may already have theme symlinks; only replace settings.ini
mkdir -p "$HOME/.config/gtk-4.0"
if [[ -f "$HOME/.config/gtk-4.0/settings.ini" ]]; then
  backup_if_exists "$HOME/.config/gtk-4.0/settings.ini"
fi
cp -a "$ROOT/config/gtk-4.0/settings.ini" "$HOME/.config/gtk-4.0/settings.ini"
echo "Installed: $HOME/.config/gtk-4.0/settings.ini"

if [[ -f "$ROOT/config/swaylock.conf" ]]; then
  backup_if_exists "$HOME/.config/swaylock.conf"
  cp -a "$ROOT/config/swaylock.conf" "$HOME/.config/swaylock.conf"
  echo "Installed: $HOME/.config/swaylock.conf"
fi

echo "==> Installing wallpapers"
mkdir -p "$HOME/Pictures/Wallpaper"
cp -a "$ROOT/wallpapers/Wallpaper/." "$HOME/Pictures/Wallpaper/"
cp -a "$ROOT/wallpapers/dark-cat-rosewater.png" "$HOME/Pictures/dark-cat-rosewater.png"

chmod +x \
  "$HOME/.config/waybar/niri-launch.sh" \
  "$HOME/.config/waybar/wallpaper-launch.sh" \
  "$HOME/.config/waybar/modules/"*.sh \
  "$HOME/.config/wofi/"*.sh 2>/dev/null || true

echo
echo "Done."
if [[ -d "$BACKUP_DIR" ]]; then
  echo "Previous configs backed up to: $BACKUP_DIR"
fi
echo "Reload niri / restart the session to apply."

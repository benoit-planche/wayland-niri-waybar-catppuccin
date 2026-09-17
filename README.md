# wayland-niri-waybar-catppuccin

Dotfiles pour un setup **Wayland** autour de **niri**, avec **Waybar**, **Catppuccin Mocha/Macchiato**, et les apps associées.

## Contenu

| Chemin | Rôle |
|--------|------|
| `config/niri/` | Compositor niri (`config.kdl`) |
| `config/waybar/` | Barre + modules niri + scripts de lancement / wallpaper |
| `config/wofi/` | Launcher (Catppuccin Mocha) |
| `config/fuzzel/` | Alternative launcher |
| `config/dunst/` | Notifications (+ `mocha.conf`) |
| `config/swaylock/` | Écran de verrouillage Catppuccin |
| `config/gtk-3.0/`, `config/gtk-4.0/` | Thème GTK Catppuccin |
| `wallpapers/` | Fonds d’écran + image swaylock |

## Dépendances (Arch / AUR)

- `niri`, `waybar`, `wofi`, `fuzzel`, `dunst`, `swaylock`, `swww`
- `xwayland-satellite`, `brightnessctl`, `wireplumber` (`wpctl`)
- Thèmes Catppuccin GTK / cursors / icônes (ex. `catppuccin-gtk-theme-macchiato`, `catppuccin-cursors-mocha`, Papirus ou Catppuccin-Mocha)

## Installation

```bash
git clone git@github.com:benoit-planche/wayland-niri-waybar-catppuccin.git
cd wayland-niri-waybar-catppuccin
./install.sh
```

Le script copie les configs vers `~/.config/` (avec sauvegarde horodatée si un dossier existe déjà) et place les wallpapers dans `~/Pictures/`.

### Chemins attendus

- Wallpapers aléatoires : `~/Pictures/Wallpaper/`
- Image swaylock : `~/Pictures/dark-cat-rosewater.png`

## Notes

- `Mod+R` lance **wofi** ; fuzzel est aussi configuré.
- Waybar démarre via `~/.config/waybar/niri-launch.sh` (appelé au démarrage niri).
- Scripts référencés mais absents de cette machine au moment du dépôt :
  - `~/.config/waybar/bt-toggle.sh`
  - `~/.config/waybar/scripts/focus_window.sh`

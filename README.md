# wayland-niri-waybar-catppuccin

Dotfiles pour un desktop **Wayland** basé sur **niri**, avec **Waybar**, **Catppuccin** (Mocha / Macchiato), et les outils associés.

## Installation rapide

Sur Arch Linux (ou dérivé) avec `paru` ou `yay` :

```bash
git clone git@github.com:benoit-planche/wayland-niri-waybar-catppuccin.git
cd wayland-niri-waybar-catppuccin

# 1) Paquets système + thèmes Catppuccin
./install-deps.sh          # utilise paru si dispo, sinon yay

# 2) Copie des configs + wallpapers
./install.sh
```

Puis, depuis ton gestionnaire de connexion (SDDM, GDM, greetd, ly…), choisis la session **niri** et connecte-toi.

Les configs existantes sont sauvegardées dans `~/.config-backup-wayland-YYYYMMDD-HHMMSS/` avant écrasement.

---

## Contenu du dépôt

| Chemin | Rôle |
|--------|------|
| `config/niri/` | Compositor niri (`config.kdl`) |
| `config/waybar/` | Barre, modules niri, scripts de lancement / wallpaper |
| `config/wofi/` | Launcher (Catppuccin Mocha) |
| `config/fuzzel/` | Launcher alternatif |
| `config/dunst/` | Notifications (+ palette `mocha.conf`) |
| `config/swaylock/` | Écran de verrouillage Catppuccin |
| `config/gtk-3.0/`, `config/gtk-4.0/` | Thème GTK |
| `wallpapers/` | Fonds d’écran + image swaylock |
| `install-deps.sh` | Installe les paquets / thèmes |
| `install.sh` | Déploie les dotfiles |

---

## Prérequis

- Distribution **Arch Linux** (recommandé) ou compatible pacman
- Un helper AUR : [`paru`](https://github.com/Morganamilo/paru) ou [`yay`](https://github.com/Jguer/yay)
- Session graphique Wayland (le greeter doit proposer `niri`)

### Paquets installés par `install-deps.sh`

**Compositor & barre**

| Paquet | Rôle |
|--------|------|
| `niri` | Compositor scrollable Wayland |
| `waybar` | Barre de statut |
| `xwayland-satellite` | Apps X11 sous niri |

**UI / theming**

| Paquet | Rôle |
|--------|------|
| `wofi` | Application launcher (`Mod+R`) |
| `fuzzel` | Launcher alternatif |
| `dunst` | Notifications |
| `swaylock` | Verrouillage d’écran |
| `swww` | Daemon de wallpapers animés |
| `nwg-look` | Réglage GTK (optionnel mais pratique) |

**Utilitaires utilisés par les binds niri**

| Paquet | Rôle |
|--------|------|
| `brightnessctl` | Luminosité clavier |
| `wireplumber` | Volume (`wpctl`) |
| `bluez` / `bluez-utils` | Bluetooth (`bluetoothctl`) |

**Thèmes Catppuccin**

| Paquet (AUR) | Rôle |
|--------------|------|
| `catppuccin-gtk-theme-macchiato` | Thème GTK (mauve) |
| `catppuccin-cursors-mocha` | Curseurs |
| `papirus-icon-theme` | Icônes (GTK-4) |

Les icônes **Catppuccin-Mocha** (GTK-3) peuvent aussi venir d’un dépôt d’icônes Catppuccin si tu les as déjà installées localement (`~/.local/share/icons` ou `~/.themes`).

> Terminal : la config niri lance `warp-terminal` (`Mod+T`). Remplace-le dans `config/niri/config.kdl` si tu utilises `kitty`, `alacritty`, etc.

---

## Installation manuelle (sans scripts)

### 1. Paquets

```bash
# Exemple avec paru
paru -S --needed \
  niri waybar wofi fuzzel dunst swaylock swww \
  xwayland-satellite brightnessctl wireplumber \
  bluez bluez-utils nwg-look papirus-icon-theme \
  catppuccin-gtk-theme-macchiato catppuccin-cursors-mocha
```

### 2. Dotfiles

```bash
mkdir -p ~/.config ~/Pictures/Wallpaper

cp -a config/niri      ~/.config/
cp -a config/waybar    ~/.config/
cp -a config/wofi      ~/.config/
cp -a config/fuzzel    ~/.config/
cp -a config/dunst     ~/.config/
cp -a config/swaylock  ~/.config/
cp -a config/gtk-3.0   ~/.config/
cp config/gtk-4.0/settings.ini ~/.config/gtk-4.0/settings.ini
cp config/swaylock.conf ~/.config/swaylock.conf

cp -a wallpapers/Wallpaper/. ~/Pictures/Wallpaper/
cp wallpapers/dark-cat-rosewater.png ~/Pictures/

chmod +x ~/.config/waybar/*.sh ~/.config/waybar/modules/*.sh ~/.config/wofi/*.sh
```

### 3. Démarrer la session

1. Active Bluetooth si besoin : `sudo systemctl enable --now bluetooth`
2. Déconnecte-toi, choisis **niri** dans le greeter
3. Au démarrage, niri lance waybar + swww (wallpaper aléatoire)

---

## Chemins attendus après install

| Usage | Chemin |
|-------|--------|
| Config niri | `~/.config/niri/config.kdl` |
| Waybar | `~/.config/waybar/` |
| Wallpapers aléatoires (`swww`) | `~/Pictures/Wallpaper/` |
| Image swaylock | `~/Pictures/dark-cat-rosewater.png` |

---

## Raccourcis utiles (niri)

| Raccourci | Action |
|-----------|--------|
| `Mod+T` | Terminal (`warp-terminal`) |
| `Mod+R` | Launcher (`wofi`) |
| `Super+Shift+L` | Verrouillage (`swaylock`) |
| Touches média | Volume / mute (`wpctl`) |
| Touches luminosité | `brightnessctl` |
| Touche Bluetooth | `~/.config/waybar/bt-toggle.sh` *(à fournir)* |

`Mod` correspond en général à la touche Super (Windows).

---

## Vérifications après install

```bash
# Binaires présents
command -v niri waybar wofi dunst swaylock swww

# Thèmes visibles
ls /usr/share/themes | grep -i catppuccin
ls /usr/share/icons  | grep -iE 'catppuccin|papirus'

# Recharger waybar sans relancer la session
~/.config/waybar/niri-launch.sh
```

Pour recharger niri après une modif de `config.kdl` : `niri msg action load-config-file` (ou relance de session).

---

## Scripts manquants

La config référence deux scripts qui ne sont **pas** fournis dans ce dépôt (absents sur la machine d’origine) :

- `~/.config/waybar/bt-toggle.sh` — toggle Bluetooth
- `~/.config/waybar/scripts/focus_window.sh` — focus fenêtre au clic sur un workspace waybar

Sans eux, le reste du setup fonctionne ; seuls ces binds/clics échoueront.

---

## Désinstallation / restauration

Si `install.sh` a créé une sauvegarde :

```bash
# Exemple
ls ~/.config-backup-wayland-*
# Puis recopier à la main les dossiers voulus vers ~/.config/
```

---

## Licence / crédit

Thème couleur : [Catppuccin](https://github.com/catppuccin/catppuccin).  
Compositor : [niri](https://github.com/YaLTeR/niri).

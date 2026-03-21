#!/usr/bin/env bash
set -euo pipefail

echo "=== Arch Hyprland Gaming Setup ==="

# ---- Enable multilib ----
if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
    echo "Enabling multilib repository..."
    sudo sed -i '/\[multilib\]/,/Include/s/^#//' /etc/pacman.conf
    sudo pacman -Sy
fi

# ---- Install official packages ----
echo "Installing packages from official repos..."
grep -v '^#' packages.txt | grep -v '^$' | sudo pacman -S --needed -

# ---- Install AUR packages ----
if command -v yay &>/dev/null; then
    echo "Installing AUR packages..."
    yay -S --needed zen-browser-bin proton-ge-custom-bin
else
    echo "yay not found — install it manually, then run:"
    echo "  yay -S zen-browser-bin proton-ge-custom-bin"
fi

# ---- Load i2c-dev module (for DDC monitor control) ----
echo "Setting up i2c-dev module..."
echo "i2c-dev" | sudo tee /etc/modules-load.d/i2c-dev.conf
sudo modprobe i2c-dev

# ---- Copy configs ----
echo "Installing config files..."
mkdir -p ~/.config/{hypr,waybar,fuzzel,dunst,swww,systemd/user}

cp hypr/hyprland.conf ~/.config/hypr/
cp hypr/hyprlock.conf ~/.config/hypr/
cp hypr/hypridle.conf ~/.config/hypr/
cp waybar/config.jsonc ~/.config/waybar/
cp waybar/style.css ~/.config/waybar/
cp waybar/tokyonight.css ~/.config/waybar/
cp fuzzel/fuzzel.ini ~/.config/fuzzel/
cp dunst/dunstrc ~/.config/dunst/
cp swww/bing-wallpaper.sh ~/.config/swww/
chmod +x ~/.config/swww/bing-wallpaper.sh
cp systemd/user/bing-wallpaper.service ~/.config/systemd/user/
cp systemd/user/bing-wallpaper.timer ~/.config/systemd/user/

# ---- Enable wallpaper timer ----
echo "Enabling Bing wallpaper timer..."
systemctl --user daemon-reload
systemctl --user enable bing-wallpaper.timer

# ---- Mount point for games SSD ----
echo ""
echo "NOTE: If you have a second SSD for games, partition and mount it:"
echo "  sudo wipefs -a /dev/<device>"
echo "  sudo parted /dev/<device> --script mklabel gpt mkpart primary ext4 0% 100%"
echo "  sudo mkfs.ext4 -L games /dev/<partition>"
echo "  sudo mkdir -p /mnt/games"
echo "  sudo mount /dev/<partition> /mnt/games"
echo "  sudo chown \$USER:\$USER /mnt/games"
echo "  echo 'LABEL=games /mnt/games ext4 defaults,noatime 0 2' | sudo tee -a /etc/fstab"
echo ""
echo "Then add /mnt/games as a Steam Library folder in Steam > Settings > Storage"

echo ""
echo "=== Done! Log out and into Hyprland to see changes. ==="

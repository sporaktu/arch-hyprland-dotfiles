# Arch Hyprland Gaming Desktop

Personal Arch Linux + Hyprland configuration for a multi-monitor gaming desktop.

## Hardware

- **GPU**: NVIDIA (open drivers)
- **Center**: LG OLED 4K @ 144Hz (HDMI) — HDR enabled, 10-bit
- **Left**: Acer XB271HU 1440p @ 144Hz (DP)
- **Right**: Philips 278E1 4K @ 60Hz (DP, 1.25x scale)
- **Storage**: 1TB NVMe (OS) + 1TB NVMe (games, mounted at /mnt/games)

## What's Included

### Hyprland
- Multi-monitor with independent workspaces per display
- Catppuccin Mocha window borders (mauve/blue gradient)
- HDR + color management for LG OLED
- Game-optimized window rules (Steam/Proton)
- Tearing enabled for lower input latency

### Waybar
- Floating island/pill design with glassmorphism
- Catppuccin Mocha palette
- Modules: workspaces, window title, media, CPU, RAM, network, volume, clock (12h)

### Fuzzel (App Launcher)
- Catppuccin Mocha theme with mauve border
- Rounded corners, AtkynsonMono Nerd Font

### Dunst (Notifications)
- Catppuccin Mocha theme
- Rounded corners, severity-based border colors

### Hyprlock (Lock Screen)
- Catppuccin Mocha theme
- 12-hour time display, blur background

### Bing Wallpaper
- Auto-fetches Bing daily wallpaper via systemd timer (4x/day)
- Smooth fade transitions with swww
- Caches images, auto-cleans old ones

## Install

```bash
git clone git@github.com:sporaktu/arch-hyprland-dotfiles.git
cd arch-hyprland-dotfiles
./install.sh
```

## Key Packages

- **Gaming**: Steam, Proton-GE, Gamescope, GameMode, MangoHUD, Lutris, Wine
- **Apps**: Zen Browser, Discord, Firefox
- **Desktop**: Waybar, Fuzzel, Dunst, Hyprlock, Hypridle, SWWW

## Keybindings

| Key | Action |
|-----|--------|
| Super + Q | Terminal (Kitty) |
| Super + R | App Launcher (Fuzzel) |
| Super + C | Close Window |
| Super + F | Fullscreen |
| Super + T | Toggle Floating |
| Super + 1-0 | Switch Workspace (per-monitor) |
| Super + Shift + 1-0 | Move Window to Workspace |
| Super + L | Lock Screen |
| Super + E | File Manager |
| Super + V | Clipboard History |
| Print | Screenshot (region to clipboard) |

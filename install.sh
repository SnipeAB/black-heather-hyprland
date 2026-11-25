#!/usr/bin/env bash
set -euo pipefail
SRC="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DEST="$HOME/.config/black-heather"
HYPR="$HOME/.config/hypr"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$HOME/.config/black-heather-backups/$STAMP"

mkdir -p "$DEST" "$HYPR" "$BACKUP"
for cfg in "$HYPR/hyprland.lua" "$HYPR/hyprland.conf"; do
  [[ -f "$cfg" ]] && cp -a "$cfg" "$BACKUP/$(basename "$cfg")"
done

for item in hypr waybar kitty rofi mako hyprlock wallpaper scripts README.md; do
  if [[ -e "$DEST/$item" ]]; then
    mkdir -p "$BACKUP/theme"
    cp -a "$DEST/$item" "$BACKUP/theme/"
    rm -rf "$DEST/$item"
  fi
  cp -a "$SRC/$item" "$DEST/"
done

# Hyprland 0.55+ uses Lua. Older releases use hyprlang.
VERSION="$(hyprctl version 2>/dev/null | sed -n 's/.*Hyprland [vV]*\([0-9][0-9.]*\).*/\1/p' | head -n1 || true)"
if [[ -f "$HYPR/hyprland.lua" ]] || [[ -n "$VERSION" && "$(printf '%s\n' "$VERSION" "0.55" | sort -V | head -n1)" == "0.55" ]]; then
  MAIN="$HYPR/hyprland.lua"
  [[ -f "$MAIN" ]] || printf -- '-- BLACK HEATHER entry point\n' > "$MAIN"
  REQUIRE="require(\"$DEST/hypr/black-heather\")"
  if ! grep -Fqx "$REQUIRE" "$MAIN"; then
    printf '\n-- BLACK HEATHER theme overlay\n%s\n' "$REQUIRE" >> "$MAIN"
  fi
  echo "Installed Lua overlay for Hyprland ${VERSION:-0.55+}."
elif [[ -f "$HYPR/hyprland.conf" ]]; then
  MAIN="$HYPR/hyprland.conf"
  SOURCE_LINE="source = $DEST/hypr/black-heather.conf"
  if ! grep -Fqx "$SOURCE_LINE" "$MAIN"; then
    printf '\n# BLACK HEATHER theme overlay\n%s\n' "$SOURCE_LINE" >> "$MAIN"
  fi
  echo "Installed hyprlang overlay."
else
  echo "Could not determine your Hyprland config format. Files copied to $DEST but not activated."
  echo "Check 'hyprctl version' and add the appropriate Lua require or hyprlang source line manually."
fi

chmod +x "$DEST/scripts/set-wallpaper.sh"
echo "Backup: $BACKUP"
read -r -p "Install recommended packages with pacman now? [y/N] " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  sudo pacman -S --needed waybar kitty rofi-wayland mako hyprlock hyprpaper \
    brightnessctl playerctl pavucontrol ttf-jetbrains-mono-nerd ttf-font-awesome
fi
echo "Done. Reload with: hyprctl reload"

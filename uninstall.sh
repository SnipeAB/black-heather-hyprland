#!/usr/bin/env bash
set -euo pipefail
DEST="$HOME/.config/black-heather"
for MAIN in "$HOME/.config/hypr/hyprland.lua" "$HOME/.config/hypr/hyprland.conf"; do
  [[ -f "$MAIN" ]] || continue
  sed -i '\|^require(".*black-heather/hypr/black-heather")$|d' "$MAIN"
  sed -i '\|^source =.*/black-heather/hypr/black-heather.conf$|d' "$MAIN"
  sed -i '\|^-- BLACK HEATHER theme overlay$|d' "$MAIN"
  sed -i '\|^# BLACK HEATHER theme overlay$|d' "$MAIN"
done
rm -rf "$DEST"
echo "Removed BLACK HEATHER theme files and source lines."
echo "Pre-install backups remain in ~/.config/black-heather-backups/."

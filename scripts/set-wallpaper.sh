#!/usr/bin/env bash
set -euo pipefail
WALL="$HOME/.config/black-heather/wallpaper/black-heather-highlands.png"
command -v hyprctl >/dev/null || exit 1
hyprctl hyprpaper preload "$WALL"
hyprctl hyprpaper wallpaper ",$WALL"

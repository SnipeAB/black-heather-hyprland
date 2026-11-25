# BLACK HEATHER — Arcane Highlands

A Scottish Highlands / dark-fantasy anime-inspired Hyprland theme for Athena OS (Arch).

## Design
- Peat-black surfaces, heather violet, glen green and restrained ember copper.
- Scottish loch / ruined-castle wallpaper made for this theme.
- Floating centred Waybar, Kitty terminal, Rofi launcher, Mako notifications and Hyprlock.
- UK keyboard layout (`gb`) and monitor auto-detection.
- Moderate blur and animations; intended to remain usable on an AMD laptop.

## Before installing
Athena OS documents its Hyprland edition as a minimal configuration intended for users to add their own dotfiles. This pack is an overlay, not a replacement desktop distribution.

1. Log into your Athena OS Hyprland session.
2. Open a terminal (Athena documents `Super+Q` as its default terminal shortcut).
3. Extract this archive.
4. Run:

```bash
cd black-heather-hyprland
chmod +x install.sh
./install.sh
```

The installer:
- backs up any files it replaces under `~/.config/black-heather-backups/<timestamp>/`;
- copies this theme into `~/.config/black-heather/`;
- adds one `source = .../black-heather.conf` line to `~/.config/hypr/hyprland.conf` if it is not already present;
- does not replace your existing Hyprland configuration.

Then log out and back in, or reload with `hyprctl reload`.

## Suggested packages

The installer can optionally install these with `pacman`:

```bash
sudo pacman -S --needed waybar kitty rofi-wayland mako hyprlock hyprpaper \
  brightnessctl playerctl pavucontrol ttf-jetbrains-mono-nerd \
  ttf-font-awesome
```

If Athena's install already provides equivalents, do not install duplicates. The theme itself does not require an AUR package.

## Keybindings added
- `Super+Return`: Kitty
- `Super+D`: Rofi application launcher
- `Super+Shift+W`: reload wallpaper
- `Super+L`: lock screen
- `Super+Shift+R`: reload Hyprland config
- `Super+Shift+Q`: close focused window
- `Super+1..9`: switch workspace
- `Super+Shift+1..9`: move focused window to workspace

Existing Athena keybindings are left intact unless they use the same combinations.

## Important notes
- The monitor line uses `preferred` and scale `1`; it lets Hyprland read the panel's native mode. If text looks too small, use `hyprctl monitors` and adjust the scale in `hypr/black-heather.conf`.
- The theme uses the `gb` keyboard layout. Change it if your physical keyboard differs.
- The laptop model string supplied does not establish the exact panel resolution or refresh rate.
- Hyprland configuration syntax can change between major releases. The installer detects the active config format: Hyprland 0.55+ uses the bundled Lua overlay; older versions use the hyprlang overlay. Hyprland 0.55 changed the config language from hyprlang to Lua, so this distinction matters.
- Blur is intentionally modest. For battery life, set `decoration:blur:enabled = false` or remove the blur block.
- Wallpaper service: `hyprpaper` (configured in `hypr/hyprpaper.conf`). Waybar and Mako start through Hyprland. Kitty is launched with the bundled Grimoire palette.

## Uninstall
Run:

```bash
./uninstall.sh
```

It removes the source line and theme directory. Your original files are preserved in the backup directory. If you want to restore a replaced file, copy it back from the newest backup.

## Troubleshooting
- Check config parse errors: `hyprctl reload`
- Inspect outputs: `hyprctl monitors`
- Check services: `pgrep -a waybar; pgrep -a mako; pgrep -a hyprpaper`
- If the bar does not appear: run `waybar` from a terminal and read its error output.


## Hyprland config compatibility

Hyprland 0.55+ loads `~/.config/hypr/hyprland.lua`; the installer adds a `require()` for `hypr/black-heather.lua`. Older hyprlang versions use `hypr/black-heather.conf` via a `source =` line. The theme files are kept separate from Athena's main config.

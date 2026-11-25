-- BLACK HEATHER — Arcane Highlands (Hyprland 0.55+ Lua configuration)
-- Loaded from ~/.config/hypr/hyprland.lua via require().
local home = os.getenv("HOME")
local theme = home .. "/.config/black-heather"

-- Let Hyprland select the panel's preferred mode; no resolution guessed.
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 12,
        border_size = 2,
        col = {
            active_border = { colors = {"rgba(a58aaeee)", "rgba(748b70ee)"}, angle = 45 },
            inactive_border = "rgba(343b43cc)",
        },
        layout = "dwindle",
        allow_tearing = false,
    },
    decoration = {
        rounding = 12,
        rounding_power = 2,
        active_opacity = 0.97,
        inactive_opacity = 0.93,
        shadow = {
            enabled = true,
            range = 18,
            render_power = 3,
            color = 0xee08090e,
        },
        blur = {
            enabled = true,
            size = 5,
            passes = 2,
            xray = false,
            noise = 0.02,
            contrast = 0.92,
            brightness = 0.82,
        },
    },
    dwindle = {
        pseudotile = true,
        preserve_split = true,
    },
    input = {
        kb_layout = "gb",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
            disable_while_typing = true,
            clickfinger_behavior = true,
        },
    },
    misc = {
        vfr = true,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
    },
})

hl.curve("bh-smooth", { type = "bezier", points = {{0.22, 1}, {0.36, 1}} })
hl.curve("bh-snap", { type = "bezier", points = {{0.16, 1}, {0.30, 1}} })
hl.animation({ leaf = "global", enabled = true, speed = 5, bezier = "bh-smooth" })
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "bh-smooth", style = "popin 92%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "bh-snap", style = "popin 92%" })
hl.animation({ leaf = "border", enabled = true, speed = 6, bezier = "bh-smooth" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "bh-smooth" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "bh-snap", style = "slide" })

-- Start theme services when the compositor session starts.
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper --config " .. theme .. "/hypr/hyprpaper.conf")
    hl.exec_cmd("waybar -c " .. theme .. "/waybar/config.jsonc -s " .. theme .. "/waybar/style.css")
    hl.exec_cmd("mako --config " .. theme .. "/mako/config")
end)

local main = "SUPER"
hl.bind(main .. " + RETURN", hl.dsp.exec_cmd("kitty --config " .. theme .. "/kitty/kitty.conf"))
hl.bind(main .. " + D", hl.dsp.exec_cmd("rofi -show drun -theme " .. theme .. "/rofi/black-heather.rasi"))
hl.bind(main .. " + L", hl.dsp.exec_cmd("hyprlock -c " .. theme .. "/hyprlock/hyprlock.conf"))
hl.bind(main .. " + SHIFT + R", hl.dsp.reload_config())
hl.bind(main .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(main .. " + F", hl.dsp.window.fullscreen())
hl.bind(main .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main .. " + P", hl.dsp.window.pseudo())
hl.bind(main .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(main .. " + SHIFT + W", hl.dsp.exec_cmd(theme .. "/scripts/set-wallpaper.sh"))

for i = 1, 9 do
    hl.bind(main .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(main .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Laptop media, volume and brightness controls.
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

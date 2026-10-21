-- ~~~ Monitor ~~~
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "0x0",
    scale    = 1,
})

-- ~~~ Autostart ~~~
hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("/usr/libexec/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("bash ~/.config/hypr/scripts/battery-alerts.sh")
    hl.exec_cmd("paplay ~/.config/hypr/assets/w11-startup.mp3")
    hl.exec_cmd("swaybg -i ~/Pictures/mocha-walls/cat-vibin.png")
end)

-- ~~~ Environment ~~~
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- ~~~ Input, look, layouts ~~~
hl.config({
    input = {
        kb_layout    = "us, lk",
        kb_variant   = "colemak_dh, sin_phonetic_colemak",
        kb_options   = "grp:alt_shift_toggle",
        follow_mouse = 1,
        sensitivity  = 0,
        accel_profile = "flat",
        touchpad = {
            natural_scroll = true,
        },
    },

    general = {
        gaps_in      = 5,
        gaps_out     = 10,
        border_size  = 2,
        col = {
            inactive_border = "rgba(25164b36)",
            active_border   = "#171723",
        },
        layout        = "dwindle",
        allow_tearing = false,
    },

    decoration = {
        rounding = 0,
        blur = {
            enabled           = true,
            size              = 2,
            passes            = 3,
            new_optimizations = true,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        -- pseudotile = true,
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    gestures = {
        workspace_swipe_distance         = 700,
        workspace_swipe_cancel_ratio     = 0,
        workspace_swipe_min_speed_to_force = 100,
        workspace_swipe_invert           = true,
        workspace_swipe_create_new       = true,
        workspace_swipe_forever          = true,
    },
})

hl.gesture({
    fingers   = 4,
    direction = "horizontal",
    action    = "workspace",
})

-- ~~~ Animations ~~~
hl.animation({ leaf = "windows",    enabled = true, speed = 2, bezier = "default" })
hl.animation({ leaf = "border",     enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "default" })

-- ~~~ Keybinds ~~~
local mod = "SUPER"

hl.bind(mod .. " + SPACE",         hl.dsp.exec_cmd("kitty"))
hl.bind(mod .. " + Q",             hl.dsp.window.close())
hl.bind(mod .. " + ALT + SPACE",   hl.dsp.exec_cmd("hyprctl switchxkblayout current next"))
hl.bind(mod .. " + W",             hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + R",             hl.dsp.exec_cmd("wofi --show drun"))
-- hl.bind(mod .. " + P",          hl.dsp.window.pseudo())
hl.bind(mod .. " + X",             hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/power-options.sh"))
hl.bind(mod .. " + A",             hl.dsp.exec_cmd("control"))
hl.bind(mod .. " + V",             hl.dsp.exec_cmd("cliphist list | wofi -S dmenu | cliphist decode | wl-copy"))
hl.bind(mod .. " + Z",             hl.dsp.exec_cmd("zen"))
hl.bind(mod .. " + F",             hl.dsp.exec_cmd("nautilus"))
hl.bind(mod .. " + L",             hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/lock.sh"))
hl.bind(mod .. " + C",             hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/caffeine.sh"))
hl.bind(mod .. " + B",             hl.dsp.exec_cmd("bash $HOME/.config/hypr/scripts/screenbgone.sh"))
hl.bind(mod .. " + SHIFT + S",     hl.dsp.exec_cmd("flameshot gui"))
hl.bind(mod .. " + F11",           hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mod .. " + SHIFT + R",     hl.dsp.exec_cmd("hyprctl reload"))

-- Move/resize windows with mouse
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Move focus
hl.bind(mod .. " + ALT + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + ALT + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + ALT + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + ALT + down",  hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(mod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- Workspaces (SUPER + 1..0, SUPER + CTRL + 1..0 to move a window)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mod .. " + " .. key,          hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + CTRL + " .. key,   hl.dsp.window.move({ workspace = i }))
end
hl.bind(mod .. " + right",        hl.dsp.focus({ workspace = "+1" }))
hl.bind(mod .. " + left",         hl.dsp.focus({ workspace = "-1" }))
hl.bind(mod .. " + CTRL + right", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mod .. " + CTRL + left",  hl.dsp.window.move({ workspace = "-1" }))

-- ~~~ Screenshots (grim + slurp) ~~~
hl.bind("Print",
    hl.dsp.exec_cmd("grim - | tee ~/Pictures/Screenshots/Screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy"),
    { locked = true })
hl.bind("SHIFT + Print",
    hl.dsp.exec_cmd("slurp | grim -g - - | tee ~/Pictures/Screenshots/Screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy"))

-- ~~~ Volume / brightness / media (swayosd) ~~~
local hold = { locked = true, repeating = true }

hl.bind("F9", hl.dsp.exec_cmd("swayosd-client --output-volume raise --max-volume 100"), hold)
hl.bind("F8", hl.dsp.exec_cmd("swayosd-client --output-volume lower --max-volume 100"), hold)
hl.bind("F7", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locked = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise"), hold)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"), hold)

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("swayosd-client --playerctl next"),       { locked = true })

hl.bind("Caps_Lock", hl.dsp.exec_cmd("swayosd-client --caps-lock"), { release = true, locked = true, ignore_mods = true })

-- ~~~ Window rules ~~~
hl.window_rule({
    name  = "better-control",
    match = { class = "^(better_control.py)$" },
    float = true,
    size  = "685 455",
})

hl.window_rule({
    name  = "ente-auth",
    match = { class = "^(io.ente.auth)$" },
    float = true,
    size  = "350 700",
    move  = "1000 50",
})

hl.window_rule({
    name  = "protonvpn",
    match = { class = "^(protonvpn-app)$" },
    float = true,
    size  = "350 500",
    move  = "500 150",
})

hl.window_rule({
    name  = "gnome-calculator",
    match = { class = "^(org.gnome.Calculator)$" },
    float = true,
    size  = "350 500",
    move  = "500 150",
})

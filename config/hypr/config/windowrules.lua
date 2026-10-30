-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                   Window & Layer Rules                      ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

-- https://wiki.hypr.land/configuring/core/rules/

local c = require("config.colors")

-- Float
local floatClasses = {
    "^(org.pulseaudio.pavucontrol)",
    "^(blueman-manager)$",
    "^(xdg-desktop-portal-gtk|xdg-desktop-portal-kde|xdg-desktop-portal-hyprland)(.*)$",
    "^(polkit-gnome-authentication-agent-1|hyprpolkitagent|org.org.kde.polkit-kde-authentication-agent-1)(.*)$",
    "^(CachyOSHello)$",
    "^(zenity)$",
}
for _, class in ipairs(floatClasses) do
    hl.window_rule({ match = { class = class }, float = true })
end

local floatTitles = {
    "^(Picture in picture)$",
    "^(Save File)$",
    "^(Open File)$",
    "^(Steam - Self Updater)$",
}
for _, title in ipairs(floatTitles) do
    hl.window_rule({ match = { title = title }, float = true })
end

hl.window_rule({ match = { class = "^(LibreWolf)$", title = "^(Picture-in-Picture)$" }, float = true })

-- Opacity
hl.window_rule({ match = { class = "^(thunar|nemo)$" },                   opacity = "0.92" })
hl.window_rule({ match = { class = "^(discord|armcord|webcord)$" },       opacity = "0.96" })
hl.window_rule({ match = { title = "^(QQ|Telegram)$" },                   opacity = "0.95" })
hl.window_rule({ match = { title = "^(NetEase Cloud Music Gtk4)$" },      opacity = "0.95" })

-- Floating media / scratch windows
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, float = true, size = { 960, 540 } })
hl.window_rule({
    match = { title = "^(imv|mpv|danmufloat|termfloat|nemo|ncmpcpp)$" },
    float = true,
    size  = { 960, 540 },
})
hl.window_rule({ match = { title = "^(danmufloat)$" },           pin = true })
hl.window_rule({ match = { title = "^(danmufloat|termfloat)$" }, rounding = 5 })

-- Firefox: no blur, fully opaque
hl.window_rule({ match = { class = "firefox$" }, no_blur = true, opacity = "1.0 override 1.0 override" })

-- Floating windows on workspaces with floating windows
hl.window_rule({
    match        = { float = true, workspace = "w[fv1-10]" },
    border_size  = 2,
    border_color = c.cachylblue,
    rounding     = 8,
})

-- Tiled windows on (maximized) fullscreen workspaces
hl.window_rule({
    match       = { float = false, workspace = "f[1-10]" },
    border_size = 3,
    rounding    = 4,
})

hl.workspace_rule({ workspace = "w[tv1-10]", gaps_out = 5, gaps_in = 3 })
hl.workspace_rule({ workspace = "f[1]",      gaps_out = 5, gaps_in = 3 })

-- Layers
hl.layer_rule({ match = { namespace = "waybar" },    animation = "slide down" })
hl.layer_rule({ match = { namespace = "wallpaper" }, animation = "fade 50%" })

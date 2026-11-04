-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                    Variables Configuration                  ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

-- https://wiki.hypr.land/configuring/core/config-options/

local c = require("config.colors")

hl.config({
    general = {
        gaps_in     = 3,
        gaps_out    = 5,
        border_size = 3,
        col = {
            active_border   = c.cachylgreen,
            inactive_border = c.cachymblue,
        },
        layout = "dwindle", -- master|dwindle
        snap = {
            enabled = true,
        },
    },

    group = {
        col = {
            border_active          = c.cachydgreen,
            border_inactive        = c.cachylgreen,
            border_locked_active   = c.cachymgreen,
            border_locked_inactive = c.cachydblue,
        },
        groupbar = {
            font_family = "Fira Sans",
            text_color  = c.cachydblue,
            col = {
                active          = c.cachydgreen,
                inactive        = c.cachylgreen,
                locked_active   = c.cachymgreen,
                locked_inactive = c.cachydblue,
            },
        },
    },

    misc = {
        font_family           = "Fira Sans",
        splash_font_family    = "Fira Sans",
        disable_hyprland_logo = true,
        col = {
            splash = c.cachylgreen,
        },
        background_color           = c.cachydblue,
        enable_swallow             = true,
        swallow_regex              = "^(nautilus|nemo|thunar|btrfs-assistant.)$",
        focus_on_activate          = true,
        vrr                        = 2,
        initial_workspace_tracking = 0,
    },

    render = {
        direct_scanout = true,
    },

    dwindle = {
        -- special_scale_factor = 0.8,
        preserve_split       = true,
    },

    master = {
        new_status           = "master",
        -- special_scale_factor = 0.8,
    },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "up",         action = "float" })
hl.gesture({ fingers = 3, direction = "down",       action = "float" })

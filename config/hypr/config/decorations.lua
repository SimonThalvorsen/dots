-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                   Decorations Configuration                 ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

-- https://wiki.hypr.land/configuring/core/config-options/#decoration

hl.config({
    decoration = {
        active_opacity   = 0.94,
        inactive_opacity = 0.96,
        rounding         = 4,

        blur = {
            size   = 8,
            passes = 1, -- more passes = more resource intensive.
            xray   = true,
        },

        shadow = {
            enabled = false,
        },
    },
})

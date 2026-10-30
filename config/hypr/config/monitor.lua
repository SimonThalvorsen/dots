-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                    Monitor Configuration                    ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

-- https://wiki.hypr.land/configuring/core/monitors/

hl.monitor({ output = "eDP-1",    mode = "1920x1200", position = "0x0",      scale = 1.2 })
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "-1920x0",  scale = 1 }) -- 1920 left
hl.monitor({
    output   = "desc:Beihai Century Joint Innovation Technology Co.Ltd 35D601",
    mode     = "3440x1440@100",
    position = "-2752x0",
    scale    = 1.25,
})

for i = 1, 5 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1" })
end
for i = 6, 10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1" })
end

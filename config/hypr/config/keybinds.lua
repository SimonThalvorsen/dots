-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                    Keybinds Configuration                   ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

-- https://wiki.hypr.land/configuring/core/binds/
-- https://wiki.hypr.land/configuring/core/dispatchers/

local d = require("config.defaults")
local mainMod = "SUPER"

local function bind(keys, dispatcher, desc, opts)
    opts = opts or {}
    opts.description = desc
    return hl.bind(keys, dispatcher, opts)
end

local function M(keys) return mainMod .. " + " .. keys end

local wob = " > /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob"

-- ======= Apps / window actions =======
bind(M("RETURN"),      hl.dsp.exec_cmd(d.terminal),    "Opens your preferred terminal emulator (" .. d.terminal .. ")")
bind(M("H"),           hl.dsp.exec_cmd(d.browser),     "Opens your preferred browser (" .. d.browser .. ")")
bind(M("Q"),           hl.dsp.window.close(),          "Closes (not kill) current window")
bind(M("SHIFT + M"),   hl.dsp.exec_cmd('loginctl terminate-user ""'), "Exits Hyprland by terminating the user sessions")
bind(M("V"),           hl.dsp.window.float(),          "Switches current window between floating and tiling mode")
bind(M("SPACE"),       hl.dsp.exec_cmd(d.applauncher), "Runs your application launcher")
bind(M("F"),           hl.dsp.window.fullscreen(),     "Toggles current window fullscreen mode")
bind(M("Y"),           hl.dsp.window.pin(),            "Pin current window (shows on all workspaces)")
bind(M("SHIFT + R"),   hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/config/randompape.sh"), "Reload wallpaper")

-- ======= Screenshots =======
bind("Print",          hl.dsp.exec_cmd(d.shot_region), "Creates a screenshot of an area")
bind("CTRL + Print",   hl.dsp.exec_cmd(d.shot_window), "Creates a screenshot of the active window")
bind("ALT + Print",    hl.dsp.exec_cmd(d.shot_screen), "Creates a screenshot of the active display")

-- ======= Groups =======
bind(M("K"),           hl.dsp.group.toggle(),          "Toggles current window group mode (ungroup all related)")
bind(M("Tab"),         hl.dsp.group.next(),            "Switches to the next window in the group")

-- ======= Gaps =======
bind(M("SHIFT + G"), function()
    hl.config({ general = { gaps_out = 5, gaps_in = 3 } })
end, "Set CachyOS default gaps")
bind(M("G"), function()
    hl.config({ general = { gaps_out = 0, gaps_in = 0 } })
end, "Remove gaps between window")

-- ======= Media keys =======
bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(
    "pactl set-sink-volume @DEFAULT_SINK@ +5% && pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\\d+(?=%)' | awk '{if($1>100) system(\"pactl set-sink-volume @DEFAULT_SINK@ 100%\")}' && pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\\d+(?=%)' | awk '{print $1}' | head -1" .. wob
), "Raise Volume", { locked = true, repeating = true })
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(
    "pactl set-sink-volume @DEFAULT_SINK@ -5% && pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\\d+(?=%)' | awk '{print $1}' | head -1" .. wob
), "Lower Volume", { locked = true, repeating = true })
bind("XF86AudioMute", hl.dsp.exec_cmd(
    "amixer sset Master toggle | sed -En '/\\[on\\]/ s/.*\\[([0-9]+)%\\].*/\\1/ p; /\\[off\\]/ s/.*/0/p' | head -1" .. wob
), "Mutes player audio", { locked = true, repeating = true })
bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), "Toggles play/pause")
bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       "Next track")
bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   "Previous track")
bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s +5%"), "Increases brightness 5%", { locked = true, repeating = true })
bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"), "Decreases brightness 5%", { locked = true, repeating = true })

-- ======= Lock / Waybar =======
bind(M("L"), hl.dsp.exec_cmd("swaylock-fancy -e -K -p 10"), "Lock the screen")
bind(M("O"), hl.dsp.exec_cmd("killall waybar; waybar"),     "Reload/restarts Waybar")

-- ======= Window movement & focus =======
local dirs = { left = "left", right = "right", up = "up", down = "down" }
for key, dir in pairs(dirs) do
    bind(M("SHIFT + " .. key), hl.dsp.window.move({ direction = dir }), "Move active window " .. dir)
    bind(M(key),               hl.dsp.focus({ direction = dir }),       "Move focus " .. dir)
end

-- ======= Resizing =======
local resizes = {
    { "right", 15, 0 }, { "left", -15, 0 }, { "up", 0, -15 }, { "down", 0, 15 },
    { "l",     15, 0 }, { "h",    -15, 0 }, { "k",  0, -15 }, { "j",    0, 15 },
}

bind(M("R"), hl.dsp.submap("resize"), "Activates window resizing mode")
hl.define_submap("resize", function()
    for _, r in ipairs(resizes) do
        bind(r[1], hl.dsp.window.resize({ x = r[2], y = r[3], relative = true }),
            "Resize (resizing mode)", { repeating = true })
    end
    bind("escape", hl.dsp.submap("reset"), "Ends window resizing mode")
end)

for _, r in ipairs(resizes) do
    bind(M("CTRL + SHIFT + " .. r[1]), hl.dsp.window.resize({ x = r[2], y = r[3], relative = true }),
        "Resize active window", { repeating = true })
end

hl.bind(M("mouse:273"), hl.dsp.window.resize(), { mouse = true }) -- Resize the window towards a direction
hl.bind(M("mouse:272"), hl.dsp.window.drag(),   { mouse = true }) -- Drag window

-- ======= Workspaces =======
for i = 1, 10 do
    local key = tostring(i % 10) -- 10 maps to key 0
    bind(M("CTRL + " .. key),  hl.dsp.window.move({ workspace = i }),                 "Move window and switch to workspace " .. i)
    bind(M("SHIFT + " .. key), hl.dsp.window.move({ workspace = i, follow = false }), "Move window silently to workspace " .. i)
    bind(M(key),               hl.dsp.focus({ workspace = i }),                       "Switch to workspace " .. i)
end

bind(M("CTRL + left"),  hl.dsp.window.move({ workspace = "-1" }), "Move window and switch to the previous workspace")
bind(M("CTRL + right"), hl.dsp.window.move({ workspace = "+1" }), "Move window and switch to the next workspace")

bind(M("PERIOD"),     hl.dsp.focus({ workspace = "e+1" }),      "Scroll through workspaces incrementally")
bind(M("COMMA"),      hl.dsp.focus({ workspace = "e-1" }),      "Scroll through workspaces decrementally")
bind(M("mouse_down"), hl.dsp.focus({ workspace = "e+1" }),      "Scroll through workspaces incrementally")
bind(M("mouse_up"),   hl.dsp.focus({ workspace = "e-1" }),      "Scroll through workspaces decrementally")
bind(M("slash"),      hl.dsp.focus({ workspace = "previous" }), "Switch to the previous workspace")

hl.config({
    binds = {
        allow_workspace_cycles            = true,
        workspace_back_and_forth          = true,
        workspace_center_on               = 1,
        movefocus_cycles_fullscreen       = true,
        window_direction_monitor_fallback = true,
    },
})

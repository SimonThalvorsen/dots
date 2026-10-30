-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                    Default Applications                     ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

hl.config({
    input = {
        kb_layout = "no",
    },
})

return {
    filemanager = "dolphin",
    applauncher = "wofi",
    terminal    = "alacritty",
    browser     = "firefox",
    idlehandler = "swayidle -w timeout 300 'swaylock -f -c 000000' before-sleep 'swaylock -f -c 000000'",
    shot_region = "grimblast copy area",
    shot_window = "grimblast copy active",
    shot_screen = "grimblast copy screen",
}

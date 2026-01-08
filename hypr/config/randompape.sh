#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/papes/1920x1200/"

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Apply the selected wallpaper
killall swaybg
swaybg -o \* -i "$WALLPAPER"

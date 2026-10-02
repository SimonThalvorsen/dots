# dots

Hyprland / waybar / nvim / fish setup.

```sh
git clone git@github.com:SimonThalvorsen/dots.git ~/dots
~/dots/sync.sh        # -n for a dry run
```

`config/` mirrors `~/.config`. `sync.sh` symlinks each file into place and
backs up anything it would overwrite to `~/.config-backup/<timestamp>/`.
To add a new file: move it into `config/<same path>`, then rerun `sync.sh`.

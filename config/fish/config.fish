source /usr/share/cachyos-fish-config/cachyos-config.fish
direnv hook fish | source
pyenv init - fish | source
set -Ux NTECH_ROOT $HOME/northern.tech
# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
   # smth smth
end

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"

# Created by `pipx` on 2026-01-15 10:47:04
set PATH $PATH /home/tide/.local/bin

set -gx EDITOR "nvim"
set -gx VISUAL "nvim"

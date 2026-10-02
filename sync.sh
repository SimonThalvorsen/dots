#!/usr/bin/env bash
# Symlink every file in ./config into ~/.config (per-file, so app state stays out of the repo).
# Existing real files are moved to ~/.config-backup/<timestamp>/ before linking.
#
#   ./sync.sh        link everything
#   ./sync.sh -n     dry run
set -euo pipefail

DOTS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$DOTS/config"
DEST="${XDG_CONFIG_HOME:-$HOME/.config}"
BACKUP="$HOME/.config-backup/$(date +%Y%m%d-%H%M%S)"
DRY=0
[[ "${1:-}" == "-n" ]] && DRY=1

run() { if ((DRY)); then echo "  [dry] $*"; else "$@"; fi; }

linked=0 skipped=0 backed=0
while IFS= read -r -d '' file; do
    rel="${file#"$SRC"/}"
    target="$DEST/$rel"

    if [[ -L "$target" && "$(readlink "$target")" == "$file" ]]; then
        skipped=$((skipped + 1))
        continue
    fi

    if [[ -e "$target" || -L "$target" ]]; then
        run mkdir -p "$BACKUP/$(dirname "$rel")"
        run mv "$target" "$BACKUP/$rel"
        echo "backup  $rel"
        backed=$((backed + 1))
    fi

    run mkdir -p "$(dirname "$target")"
    run ln -s "$file" "$target"
    echo "link    $rel"
    linked=$((linked + 1))
done < <(find "$SRC" -type f -print0 | sort -z)

echo
echo "linked: $linked  up-to-date: $skipped  backed up: $backed"
((backed)) && echo "backups in: $BACKUP"
exit 0

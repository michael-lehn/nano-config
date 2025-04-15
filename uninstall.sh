#!/bin/bash

set -e

# --- Sprachumschaltung ---
if [[ "$LANG" =~ ^de ]]; then
    MSG_REMOVING="Entferne symbolischen Link:"
    MSG_RESTORING="Wiederherstellen von Sicherung"
    MSG_NO_BACKUP="Keine Sicherung gefunden"
    MSG_PROMPT_RESTORE="Möchtest du eine Sicherung wiederherstellen? [j/N]"
    MSG_PROMPT_DELETE_REPO="Möchtest du das automatisch geklonte Repository ~/.nano-config ebenfalls löschen? [j/N]"
    MSG_DONE="Fertig!"
    MSG_DELETED="Gelöscht:"
else
    MSG_REMOVING="Removing symbolic link:"
    MSG_RESTORING="Restoring backup"
    MSG_NO_BACKUP="No backup found"
    MSG_PROMPT_RESTORE="Do you want to restore a backup? [y/N]"
    MSG_PROMPT_DELETE_REPO="Do you also want to delete the auto-cloned repository ~/.nano-config? [y/N]"
    MSG_DONE="Done!"
    MSG_DELETED="Deleted:"
fi

HOME_DIR="$HOME"

restore_latest_backup() {
    local base="$1"
    local latest=""
    for f in "$HOME_DIR"/$base.saved.*; do
        if [ -e "$f" ]; then
            latest="$f"
        fi
    done

    if [ -n "$latest" ]; then
        echo "🔄 $MSG_RESTORING: $latest → $HOME_DIR/$base"
        mv "$latest" "$HOME_DIR/$base"
    else
        echo "⚠️  $MSG_NO_BACKUP: $base"
    fi
}

remove_and_optionally_restore() {
    local target="$1"
    local base=$(basename "$target")

    if [ -L "$target" ]; then
        echo "🗑  $MSG_REMOVING $target"
        rm "$target"

        read -r -p "❓ $MSG_PROMPT_RESTORE " answer
        if [[ "$LANG" =~ ^de ]]; then
            [[ "$answer" =~ ^[Jj] ]] && restore_latest_backup "$base"
        else
            [[ "$answer" =~ ^[Yy] ]] && restore_latest_backup "$base"
        fi
    else
        echo "ℹ️  $target is not a symbolic link – skipping."
    fi
}

remove_and_optionally_restore "$HOME_DIR/.nanorc"
remove_and_optionally_restore "$HOME_DIR/.nano"

# --- Nur bei Aufruf via curl: ~/.nano-config löschen ---
AUTO_REPO="$HOME_DIR/.nano-config"
if [[ -z "$BASH_SOURCE" ]] && [ -d "$AUTO_REPO" ]; then
    echo ""
    read -r -p "❓ $MSG_PROMPT_DELETE_REPO " answer
    if [[ "$LANG" =~ ^de ]]; then
        [[ "$answer" =~ ^[Jj] ]] && rm -rf "$AUTO_REPO" && echo "🗑️  $MSG_DELETED $AUTO_REPO"
    else
        [[ "$answer" =~ ^[Yy] ]] && rm -rf "$AUTO_REPO" && echo "🗑️  $MSG_DELETED $AUTO_REPO"
    fi
fi

echo "✅ $MSG_DONE"


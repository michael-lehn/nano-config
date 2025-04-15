#!/bin/bash

set -e

if [[ "$LANG" =~ ^de ]]; then
    MSG_BACKUP="Gesichert"
    MSG_EXISTS="existiert bereits – wird gesichert"
    MSG_LINKED="Verknüpft"
    MSG_INSTALLING="Installiere nano-Konfiguration..."
    MSG_DONE="Fertig! Du kannst jetzt nano wie gewohnt verwenden."
    MSG_PULL="Mit 'git pull' im Ordner ~/.nano-config bekommst du künftige Updates."
    MSG_CLONE="Klonen des Repositories nach ~/.nano-config..."
else
    MSG_BACKUP="Backed up"
    MSG_EXISTS="already exists – backing it up"
    MSG_LINKED="Linked"
    MSG_INSTALLING="Installing nano configuration..."
    MSG_DONE="Done! You can now use nano as usual."
    MSG_PULL="Use 'git pull' in the ~/.nano-config folder to get future updates."
    MSG_CLONE="Cloning repository into ~/.nano-config..."
fi

DEFAULT_REPO_DIR="$HOME/.nano-config"

if [[ -n "$BASH_SOURCE" ]]; then
    REPO_DIR="$(cd "$(dirname "$BASH_SOURCE")" && pwd)"
else
    if [ ! -d "$DEFAULT_REPO_DIR" ]; then
        echo "📥 $MSG_CLONE"
        git clone https://github.com/michael-lehn/nano-config.git "$DEFAULT_REPO_DIR"
    fi
    cd "$DEFAULT_REPO_DIR"
    REPO_DIR="$DEFAULT_REPO_DIR"
fi

HOME_DIR="$HOME"

SRC_RC="$REPO_DIR/nanorc"
SRC_DIR="$REPO_DIR/nano"

DEST_RC="$HOME_DIR/.nanorc"
DEST_DIR="$HOME_DIR/.nano"

backup_if_exists() {
    local target="$1"
    local base=$(basename "$target")
    local n=1
    while [ -e "$HOME_DIR/$base.saved.$n" ]; do
        ((n++))
    done
    mv "$target" "$HOME_DIR/$base.saved.$n"
    echo "✔️  $MSG_BACKUP: $target → $base.saved.$n"
}

link_file() {
    local source="$1"
    local target="$2"

    if [ -L "$target" ] || [ -e "$target" ]; then
        echo "🔄  $target $MSG_EXISTS"
        backup_if_exists "$target"
    fi

    ln -s "$source" "$target"
    echo "✅  $MSG_LINKED: $target → $source"
}

echo "📦 $MSG_INSTALLING"

link_file "$SRC_RC" "$DEST_RC"
link_file "$SRC_DIR" "$DEST_DIR"

echo "🎉 $MSG_DONE"
echo "💡 $MSG_PULL"


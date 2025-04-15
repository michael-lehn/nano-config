#!/bin/bash

set -e

# --- Sprachumschaltung ---
if [[ "$LANG" =~ ^de ]]; then
    MSG_TABLE_HEADER="Datei            | Typ               | Löschen?"
    MSG_LINK="symbolischer Link"
    MSG_OTHER="kein Link"
    MSG_YES="ja"
    MSG_NO="nein"
    MSG_REMOVING="Entferne symbolischen Link:"
    MSG_DONE="Fertig!"
    MSG_DELETED="Gelöscht:"
else
    MSG_TABLE_HEADER="File             | Type              | Remove?"
    MSG_LINK="symbolic link"
    MSG_OTHER="not a link"
    MSG_YES="yes"
    MSG_NO="no"
    MSG_REMOVING="Removing symbolic link:"
    MSG_DONE="Done!"
    MSG_DELETED="Deleted:"
fi

HOME_DIR="$HOME"
AUTO_REPO="$HOME_DIR/.nano-config"

# --- erkennen, ob wir via `curl | bash` laufen ---
IS_CURL_RUN=0
[[ "$0" == "bash" && ! -t 0 ]] && IS_CURL_RUN=1

# --- vorbereiten ---
declare -A TYPE
declare -A REMOVE

for name in ".nanorc" ".nano" ".nano-config"; do
    full="$HOME_DIR/$name"
    if [ -L "$full" ]; then
        TYPE["$name"]="$MSG_LINK"
        REMOVE["$name"]="yes"
    elif [ -e "$full" ]; then
        TYPE["$name"]="$MSG_OTHER"
        REMOVE["$name"]="no"
    else
        TYPE["$name"]="-"
        REMOVE["$name"]="no"
    fi
done

# Spezialregel für .nano-config
if [[ "${REMOVE[".nano-config"]}" == "yes" && "$IS_CURL_RUN" -eq 0 ]]; then
    REMOVE[".nano-config"]="no"
fi

# --- Tabelle anzeigen ---
echo ""
echo "$MSG_TABLE_HEADER"
echo "------------------|-------------------|----------"
for name in ".nanorc" ".nano" ".nano-config"; do
    printf "%-17s| %-18s| %s\n" "$name" "${TYPE[$name]}" "${REMOVE[$name] == "yes" && "$MSG_YES" || "$MSG_NO"}"
done
echo ""

# --- löschen ---
for name in ".nanorc" ".nano"; do
    full="$HOME_DIR/$name"
    if [[ "${REMOVE[$name]}" == "yes" ]]; then
        echo "🗑  $MSG_REMOVING $full"
        rm "$full"
    fi
done

# --- .nano-config löschen falls erlaubt ---
if [[ "${REMOVE[".nano-config"]}" == "yes" ]]; then
    echo "🗑  $MSG_REMOVING $AUTO_REPO"
    rm -rf "$AUTO_REPO"
    echo "🗑️  $MSG_DELETED $AUTO_REPO"
fi

echo "✅ $MSG_DONE"


#!/bin/bash

# Required:
# @raycast.schemaVersion 1
# @raycast.title Open Directory
# @raycast.mode silent

# Optional:
# @raycast.packageName Utilities
# @raycast.icon images/finder.png
# @raycast.argument1 { "type": "text", "placeholder": "Folder"}

# Documentation:
# @raycast.description Open directory by shortcut
# @raycast.author Andrey Lubovskiy
# @raycast.authorURL https://github.com/lubovskiy

FILENAME="cache/shortcuts.json"
arg=$1

if [ -f $FILENAME ]; then
    DIR_VAL=$(jq -r .$arg $FILENAME)
    if [[ $DIR_VAL != "null" ]]; then
        cd /
        open $DIR_VAL
    else
        echo "Shortcut not found"
    fi
else
    mkdir cache
    touch $FILENAME
    echo "Shortcut not found"
fi

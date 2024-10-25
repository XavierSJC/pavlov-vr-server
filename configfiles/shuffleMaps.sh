#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <path/to/Game.ini>"
    exit 1
fi

if [ -e "$1" ]; then
    input_file="$1"
else
    echo "$FILE does not exist."
    exit 2
fi

# Copy all lines but that start with map
grep -v '^MapRotation=' "$input_file" > "${input_file}.shuffled"

# Copy lines starting with 'map' and shuffle it
grep '^MapRotation=' "$input_file" | shuf >> "${input_file}.shuffled"

mv "${input_file}.shuffled" "${input_file}"
echo "map rotation shuffled"
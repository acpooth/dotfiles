#!/bin/bash

# List of folders to check and create
folders=(
    "alacritty"
    "awesome"
    "doom"
    "kupfer"
    "picom"
    "qtile"
)

# Directory where you want to create these themes
#dot_directory="$HOME/prueba/directorios"
this_directory="./"
dot_directory="$HOME/.config"

# Create base directory if it doesn't exist
mkdir -p "$dot_directory"

for folder in "${folders[@]}"; do
    # Full path for the current theme
    full_path="$dot_directory/$folder"
    origin_path="$this_directory/$folder/"
    if [ ! -d "$full_path" ]; then
        echo "Creating $full_path..."
        mkdir -p "$full_path"
        # Optionally, you can add initialization files or directories inside each theme folder
        # For example:
        # touch "$full_path/README.md"
        # touch "$full_path/style.css"
    else
        echo "$full_path already exists."
    fi
    echo "Overwriting the "$folder" content..."
    rsync -a $origin_path $full_path
done

echo "Folder check, creation and sync complete."

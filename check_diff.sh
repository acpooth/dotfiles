#!/bin/bash

# ANSI Color Codes
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# List of folders to check
folders=(
    "alacritty"
    "awesome"
    "doom"
    "kupfer"
    "picom"
    "qtile"
    "rofi"
    "hypr"
    "waybar"
    "fish"
)

# Allow checking a single specific folder if passed as an argument
show_diffs=false
if [ -n "$1" ]; then
    # Remove trailing slash if present
    folders=("${1%/}")
    show_diffs=true
fi

this_directory="./"
dot_directory="$HOME/.config"

echo -e "${CYAN}Verificando diferencias entre el sistema ($dot_directory) y el repositorio local ($this_directory)...${NC}"
echo "----------------------------------------------------"

for folder in "${folders[@]}"; do
    repo_path="${this_directory}${folder}"
    sys_path="${dot_directory}/${folder}"
    
    echo -e "\n${YELLOW}=== Revisando carpeta: $folder ===${NC}" # More evident separation
    echo "----------------------------------------------------"

    if [ -d "$repo_path" ]; then
        found_diffs_in_folder=false # Flag to check if any diffs were found in the current folder

        # Busca todos los archivos en el repositorio local (ignorando los que terminan en ~)
        while read -r repo_file; do
            # Extrae la ruta relativa del archivo dentro de la carpeta
            rel_path="${repo_file#$repo_path/}"
            sys_file="${sys_path}/${rel_path}"
            
            if [ -f "$sys_file" ]; then
                diff_output=$(diff -u "$repo_file" "$sys_file")
                if [ -n "$diff_output" ]; then
                    echo -e "${RED}Diferencias en: $folder/$rel_path${NC}"
                    if [ "$show_diffs" = true ]; then
                        echo "$diff_output" # diff -u usually has colors itself, so not coloring this part directly for now
                        echo ""
                    fi
                    found_diffs_in_folder=true
                fi
            else
                echo -e "${RED}Archivo ausente en el sistema: $sys_file${NC}"
                found_diffs_in_folder=true
            fi
        done < <(find "$repo_path" -type f ! -name "*~")
        
        if [ "$found_diffs_in_folder" = false ]; then
            echo -e "${GREEN}No se encontraron diferencias para la carpeta '$folder'.${NC}"
        fi
    else
        echo -e "${RED}El directorio del repositorio '$repo_path' no existe.${NC}"
    fi
    echo "----------------------------------------------------"
done

echo -e "${CYAN}Revisión completada.${NC}"

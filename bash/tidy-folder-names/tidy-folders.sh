#!/usr/bin/env bash

# Set default values for arguments
directory=${1:-$(pwd)}
case_style=${2:-kebab-case}

# Function to convert to kebab-case
to_kebab_case() {
  echo "$1" | sed -E 's/([a-z])([A-Z0-9])/\1-\2/g' | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr '_' '-'
}

# Function to convert to snake_case
to_snake_case() {
  echo "$1" | sed -E 's/([a-z])([A-Z0-9])/\1-\2/g' | tr '[:upper:]' '[:lower:]' | tr ' ' '_' | tr '-' '_'
}

# Function to convert to CamelCase
to_camel_case() {
  echo "$1" | awk -F'[-_ .]' '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1' OFS=''
}

rename_folders() {
  # Iterate all items in the directory but only process folders
  for item in "$directory"/*; do
    if [ -d "$item" ]; then
      base_name=$(basename "$item")
      case "$case_style" in
        kebab-case)
          new_name=$(to_kebab_case "$base_name")
          ;;
        snake_case)
          new_name=$(to_snake_case "$base_name")
          ;;
        CamelCase)
          new_name=$(to_camel_case "$base_name")
          ;;
      esac

      # Rename the item if the name has changed
      if [ "$base_name" != "$new_name" ]; then
        mv "$item" "$directory/$new_name"
      fi
    fi
  done
}

case "$case_style" in
  kebab-case|snake_case|CamelCase)
    rename_folders
    ;;
  *)
    echo "Usage: $0 [directory] [kebab-case|snake_case|CamelCase]"
    exit 1
    ;;
esac

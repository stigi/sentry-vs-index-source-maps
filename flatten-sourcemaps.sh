#!/bin/bash

# Ensure the flatten-source-map package is installed
if ! node -e "require('flatten-source-map')" &>/dev/null; then
  echo "Error: 'flatten-source-map' package is not installed."
  exit 1
fi

# Check if a folder parameter is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <folder> [--dry-run]"
  exit 1
fi

# Parse parameters
folder="$1"
dry_run=false
if [ "$2" == "--dry-run" ]; then
  dry_run=true
fi

# Change to the specified folder
if [ ! -d "$folder" ]; then
  echo "Error: Folder '$folder' does not exist."
  exit 1
fi
cd "$folder"

# Process each .js.map file
for file in *.js.map; do
  if [ -f "$file" ]; then
    if $dry_run; then
      output="${file}.flattened"
    else
      output="$file"
    fi

    node -e "
      const fs = require('fs');
      const flattenSourceMap = require('flatten-source-map');
      const jsonSourceMap = JSON.parse(fs.readFileSync('$file', 'utf8'));
      const flattened = flattenSourceMap(jsonSourceMap);
      fs.writeFileSync('$output', JSON.stringify(flattened, null, 2));
    "

    if $dry_run; then
      echo "Dry run: Processed $file -> $output"
    else
      echo "Processed and replaced: $file"
    fi
  fi
done
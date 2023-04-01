#!/bin/bash

# This script updates the title of a Flutter web application.
# It takes a single argument, which is the new title.

# Check that the argument is provided
if [[ $# -eq 0 ]]; then
  echo "Please provide the new title as an argument."
  exit 1
fi

# Define the file to modify
index_file="/web/index.html"

# Replace the existing title with the new title
sed -i "" "s/<title>.*<\/title>/<title>$1<\/title>/" "web/index.html"

# Confirm that the modification was successful
echo "The title of the Flutter web application has been updated to '$1'."

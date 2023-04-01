#!/bin/bash

# This script updates the names of a Flutter application for iOS, Android, and Web.
# It takes a single argument, which is the new name.

# Check that the argument is provided
if [[ $# -eq 0 ]]; then
  echo "Please provide the new name as an argument."
  exit 1
fi

# Get the absolute path of the tools directory
TOOLS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Update the name for iOS
"$TOOLS_DIR/rename_ios.sh" "$1"

# Update the name for Android
"$TOOLS_DIR/rename_android.sh" "$1"

# Update the title for the web app
"$TOOLS_DIR/rename_web.sh" "$1"

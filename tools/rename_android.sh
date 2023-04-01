#!/bin/bash

# Check if the script was passed an argument
if [ $# -lt 1 ]; then
  echo "You must specify a new app name"
  exit 1
fi

# Set the new app name
APP_NAME=$1

# Path to the AndroidManifest.xml file
MANIFEST_FILE="./android/app/src/main/AndroidManifest.xml"

# Update the app name in the AndroidManifest.xml file
sed -i '' "s/android:label=\"[^\"]*\"/android:label=\"$APP_NAME\"/g" $MANIFEST_FILE

# Confirm that the modification was successful
echo "The title of the Flutter Android application has been updated to '$1'."
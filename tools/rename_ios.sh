#!/bin/bash

# Check if the script was passed an argument
if [ $# -lt 1 ]; then
  echo "You must specify a new app name"
  exit 1
fi

# Set the new app name
APP_NAME=$1

# Path to the .xcodeproj file
PROJECT_PATH="./ios/Runner.xcodeproj"

# Get the name of the current target
TARGET_NAME=$(xcodebuild -list -project $PROJECT_PATH | grep "Targets:" -A 1 | tail -n 1 | awk '{$1=$1;print}')

# Update the app name in the Info.plist files
find ./ios -name Info.plist -exec plutil -replace CFBundleDisplayName -string "$APP_NAME" {} \;
find ./ios -name Info.plist -exec plutil -replace CFBundleName -string "$APP_NAME" {} \;

# Update the app name in the Xcode project file
sed -i '' -e "s/PRODUCT_NAME = $TARGET_NAME;/PRODUCT_NAME = $APP_NAME;/g" $PROJECT_PATH/project.pbxproj || exit 1

# Confirm that the modification was successful
echo "The title of the Flutter iOS application has been updated to '$1'."
#!/bin/bash
path="$HOME/Pictures/wallpaper.png"
# Count the number of desktops
desktops=$(osascript -e 'tell application "System Events" to get count of desktops')
ret=$?
if [ $ret -ne 0 ]; then
    echo "Failed to retrieve the number of desktops."
    exit 1
fi
# Loop through each desktop and set the wallpaper
for (( d=1; d<=$desktops; d++ ))
do
    osascript -e "tell application \"System Events\" to set picture of desktop $d to \"$path\"" 
    ret=$?
    if [ $ret -ne 0 ]; then
        echo "Failed to set wallpaper for desktop $d."
    else
        echo "Wallpaper set successfully for desktop $d."
    fi
done
# Final message
echo "Operation completed."

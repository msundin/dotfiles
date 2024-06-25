#!/bin/bash

# Path to your i3 config file
I3_CONFIG_PATH="$HOME/.config/i3/config"

# Count the number of connected displays
DISPLAY_COUNT=$(xrandr --listmonitors | grep "Monitors:" | awk '{print $2}')

# Define the mod keys
MOD1="set \$mod Mod1"
MOD4="set \$mod Mod4"

# Function to update the i3 config file
update_i3_config() {
    if grep -q "^set \$mod" "$I3_CONFIG_PATH"; then
        sed -i "s/^set \$mod.*/$1/" "$I3_CONFIG_PATH"
    else
        echo "$1" >> "$I3_CONFIG_PATH"
    fi
}

# Update the i3 config based on the number of connected displays
if [ "$DISPLAY_COUNT" -gt 1 ]; then
    update_i3_config "$MOD4"
else
    update_i3_config "$MOD1"
fi

# Comment out or remove the following line
# i3-msg restart

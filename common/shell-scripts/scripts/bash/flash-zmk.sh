#!/bin/bash

# Check if the number of arguments is less than 3
if [ $# -lt 3 ]; then
    echo "Usage: $0 zipfile leftOrRight devicePath"
    exit 1  # Exit the script with an error code
fi

# Assign arguments to variables for better readability
zipfile=$1
side=$2
devicePath=$3

# Validate the side argument to ensure it is either 'left' or 'right'
if [[ "$side" != "left" && "$side" != "right" ]]; then
    echo "Error: second argument must be 'left' or 'right'"
    exit 1
fi

# Unzip the file to the specified directory, creating the directory if it doesn't exist
mkdir -p ~/corne/"$side"
unzip -o "$zipfile" -d ~/corne/"$side"/

# Mount the device
sudo mount "$devicePath" /mnt
if [ $? -ne 0 ]; then  # Check if mount was successful
    echo "Error mounting device at $devicePath"
    exit 1
fi

# Copy the firmware to the mounted device
sudo cp ~/corne/"$side"/zmk.uf2 /mnt
if [ $? -ne 0 ]; then  # Check if copy was successful
    echo "Error copying firmware to device"
    sudo umount /mnt  # Attempt to unmount before exiting
    exit 1
fi

# Clean up: unmount the device
sudo umount /mnt
if [ $? -ne 0 ]; then
    echo "Error unmounting device"
    exit 1
fi

echo "Firmware updated successfully."


#!/usr/bin/env bash
# https://github.com/petvas/i3lock-blur/blob/master/lock.sh

ICON=/home/mattias/.config/i3/scripts/lock.png
img=/tmp/i3lock.png

scrot -o $img
convert $img -scale 10% -scale 1000% -blur 2x8 $ICON -gravity center -composite -matte $img
#convert $img -scale 10% -scale 1000% -blur 0x4 $ICON -gravity center -composite -matte $img

i3lock -e -i $img

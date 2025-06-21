#!/bin/bash
swaynag -t warning -m "Do you want to screen record?" \
  -b "Yes" "sh -c 'pkill swaynag; kitty ~/.config/sway/scripts/record.sh'" \
  -b "No" "pkill swaynag"

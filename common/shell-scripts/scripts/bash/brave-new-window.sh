#!/bin/bash
open -na "Brave Browser"
sleep 0.7
/opt/homebrew/bin/yabai -m window --space recent
osascript -e 'tell application "Brave Browser" to activate'

#! /usr/bin/bash
# The script is swaywm specific but it could be adapted for i3wm
# Set your kb identifier

swaymsg -t subscribe -m '["window", "input"]' | jq -crM --unbuffered 'select( .input.identifier == "1:1:AT_Translated_Set_2_keyboard" or .change == "focus" )'

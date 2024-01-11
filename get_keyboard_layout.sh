#!/usr/bin/bash
# The script is swaywm specific but it could be adapted for i3wm
# Set your kb identifier and kb layouts

KB_LAYOUT=$(swaymsg -r -t get_inputs | jq -rcM '.[] | select( .identifier == "1:1:AT_Translated_Set_2_keyboard" ) | .xkb_active_layout_name')

if [ "${KB_LAYOUT}" = "Bulgarian (traditional phonetic)" ]; then KB_LAYOUT="🇧🇬"; fi
if [ "${KB_LAYOUT}" = "English (US)" ]; then KB_LAYOUT="🇺🇸"; fi

echo ${KB_LAYOUT}

#!/usr/bin/bash
# The script is swaywm specific but it could be adapted for i3wm
# Set your kb identifier and kb layouts

# This is very hacky way to get current KB layout, but it seems to be some of the most reliable ones.
# These values are for 'English (US)' and 'Bulgarian (traditional phonetic)' keyboard layouts.
# You should find yours and add them here.
if [ "${XDG_SESSION_DESKTOP}" = "i3" ]; then
    LED_MASK=$(xset -q | grep LED | awk '{print $10}')

    LED_MASK_US=" 00000000 00000001 00000002 "
    if [[ " ${LED_MASK_US} " =~ " ${LEDMASK} " ]]; then
        KB_LAYOUT="🇺🇸"
    fi

    LED_MASK_BG=" 00001000 00001004 00001005 00001006 00001007 "
    if [[ " ${LED_MASK_BG} " =~ " ${LED_MASK} " ]]; then
        KB_LAYOUT="🇧🇬"
    fi
else
    KB_LAYOUT=$(swaymsg -r -t get_inputs | jq -rcM '.[] | select( .identifier == "1:1:AT_Translated_Set_2_keyboard" ) | .xkb_active_layout_name')
    if [ "${KB_LAYOUT}" = "Bulgarian (traditional phonetic)" ]; then KB_LAYOUT="🇧🇬"; fi
    if [ "${KB_LAYOUT}" = "English (US)" ]; then KB_LAYOUT="🇺🇸"; fi
fi

echo ${KB_LAYOUT}

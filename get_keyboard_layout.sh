#!/usr/bin/bash
# The script is swaywm specific but it could be adapted for i3wm
# Set your kb identifier and kb layouts

# This is very hacky way to get current KB layout, but it seems to be some of the most reliable ones.
# These values are for 'English (US)' and 'Bulgarian (traditional phonetic)' keyboard layouts.
# You should find yours and add them here.
if [ "${XDG_SESSION_DESKTOP}" = "i3" ]; then
    LED_MASK=$(xset -q | grep LED | awk '{print $10}')
    if [ "${LED_MASK}" = "00000000" ] || [ "${LED_MASK}" = "00000001" ] || [ "${LED_MASK}" = "00000002" ] || [ "${LED_MASK}" = "00000002" ]; then
        KB_LAYOUT="🇺🇸"
    fi
    if [ "${LED_MASK}" = "00001004" ] || [ "${LED_MASK}" = "00001005" ] || [ "${LED_MASK}" = "00001006" ] || [ "${LED_MASK}" = "00001007" ]; then
        KB_LAYOUT="🇧🇬"
    fi
else
    KB_LAYOUT=$(swaymsg -r -t get_inputs | jq -rcM '.[] | select( .identifier == "1:1:AT_Translated_Set_2_keyboard" ) | .xkb_active_layout_name')
    if [ "${KB_LAYOUT}" = "Bulgarian (traditional phonetic)" ]; then KB_LAYOUT="🇧🇬"; fi
    if [ "${KB_LAYOUT}" = "English (US)" ]; then KB_LAYOUT="🇺🇸"; fi
fi

echo ${KB_LAYOUT}

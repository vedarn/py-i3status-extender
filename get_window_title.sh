#! /usr/bin/bash
# The script is swaywm specific but it should be possible to be adapted for i3wm
#
# I chose to parse standard output of swaymsg instead of JSON as it easy to
# get the name of the focused window because if many nesteed windows are
# open this can complicate jq expression nedded to get window name.
# It will be like this until I manage to get jq working.

W_TITLE=$(swaymsg -t get_tree | grep "\"focused\": true" -A 30 | grep name)

echo ${W_TITLE::-2} | cut -c10-

#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import json
import subprocess
import os

script_dir = os.path.dirname(os.path.realpath(__file__))

if sys.version_info[0] == 2:
    reload(sys)
    sys.setdefaultencoding('utf8')


# Two example functions for getting current window title and keyboard layout
def get_window_title():
    window_title_read = subprocess.check_output(script_dir + "/get_window_title.sh", shell=True)
    window_title = window_title_read.decode('utf-8')
    window_title = window_title.replace("\\/", "/").replace("\n", "").replace("\\\"", "\"")
    return window_title

def get_kb_layout():
    kb_layout_read = subprocess.check_output(script_dir + "/get_keyboard_layout.sh", shell=True)
    kb_layout = kb_layout_read.decode('utf-8')
    kb_layout = kb_layout.replace("\\/", "/").replace("\n", "")
    return kb_layout

def read_line():
    """ Interrupted respecting reader for stdin. """
    # try reading a line, removing any extra whitespace
    try:
        line = sys.stdin.readline().strip()
        # i3status sends EOF, or an empty line
        if not line:
            sys.exit(3)
        return line
    # exit on ctrl-c
    except KeyboardInterrupt:
        sys.exit()

def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()


if __name__ == '__main__':
    # Skip the first line which contains the version header.
    print_line(read_line())

    # The second line contains the start of the infinite array.
    print_line(read_line())

    while True:

        line, prefix = read_line(), ''
        # ignore comma at start of lines
        if line.startswith(','):
            line, prefix = line[1:], ','
        if True:
            j = json.loads(line)
            # insert information into the start of the json, but could be anywhere
            # CHANGE THIS LINE TO INSERT SOMETHING ELSE
            j.insert(0, {'color' : '#9ec600', 'full_text' : '%s' % (get_kb_layout()), 'name' : 'kb_layout'})
            j.insert(0, {'color' : '#9ec600', 'full_text' : '%s' % (get_window_title()), 'name' : 'window_title'})
            # and echo back new encoded json
            print_line(prefix+json.dumps(j))
        else:
            j = json.loads(line)
            print_line(prefix+json.dumps(j))
            #print_line(json.dumps(j))

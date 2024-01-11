# py-i3status-extender
Simple extender for i3status status line in python

## Overview
The main reason for creating this small bunch of scripts was to keep the functionality I already had in i3wm when decided to migrate to swaywm keeping i3status at the same time. I was using additional application for displaying window title in i3status which updates the status bar when window focus was changed. Similar to other tiling WMs.

In the end I manage to get these scripts working on both i3wm and swaywm.

## Short summary on script usage

### py-i3status-extender.py
Output of i3status should be piped through the script so that it can prepend/append additional entries to the output. WM bar configuration in main  config file should look like this:
```
bar {
    position top
    status_command i3status -c ~/.config/i3/i3status.conf | python3 /path/to/py-i3status-extender.py
}
```
Set your local path to the script.

The script is easily extendable by adding new simple get function and related shell script. I added window title and keyboard layout scripts for example to be followed by anyone wishing to contribute.

### update_i3status_on_event.py
It is used for monitoring WM for particular events and forcing i3status to update its output if certain event occurs. It should be added as `exec` clause in WM main configuration file so that it gets started only once by the WM.
```
exec python3 /path/to/update_i3status_on_event.py
```
Set your local path to the script.

### Shell scripts
The shell scripts work with both i3wm and swaywm, except for `event_subscriber.sh` in the case of monitoring keyboard layout change in i3wm.

## Requirements
* [command_runner](https://github.com/netinvent/command_runner) for runing commands in python. It can be installed with pip:
```bash
pip3 install --user command_runner
```
* [jq](https://jqlang.github.io/jq/) for parsing JSON output in shell scripts


## Credits:
* https://github.com/rpieja/i3spotifystatus - main script for parsing i3status JSON output was taken from here
* https://github.com/rholder/i3status-title-on-bar - the idea for window title on bar and how to update i3status output were taken from here

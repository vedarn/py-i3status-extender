from command_runner import command_runner
import json
import os

script_dir = os.path.dirname(os.path.realpath(__file__))

def callback_function(line):
    # ~ print for debug purposes
    # ~ sway_json_resp = json.loads(line)
    # ~ print(sway_json_resp)

    command_runner("killall -USR1 i3status", silent=True)

command_runner(script_dir + "/event_subscriber.sh", stdout=callback_function, method='poller', timeout=0)

#!/usr/bin/env python3

import subprocess
import regex

devices = subprocess.run(["bluetoothctl",  "devices"],
                         capture_output=True, text=True)
uuids = [dev.split()[1] for dev in devices.stdout.splitlines()]

for uuid in uuids:
    info = subprocess.run(["bluetoothctl", "info", uuid],
                          capture_output=True).stdout.decode("utf-8")
    if info.find("Connected: yes") != -1:
        for l in info.splitlines():
            if regex.findall(r"UUID|Manufacturer", l) == []:
                print(l)

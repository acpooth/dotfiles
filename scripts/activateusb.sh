#!/bin/bash

for dev in /sys/bus/usb/devices/usb*/power/control; do
        echo $dev
        echo on > $dev
done

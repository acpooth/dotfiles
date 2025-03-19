#!/bin/bash
cd $HOME
touchPadId=$(xinput list | grep -i Point | grep "PS/2 Generic Mouse" | cut -d "=" -f 2 | cut -b 1-2)
#echo Device ID: $touchPadId

if [ "$touchPadId" = "" ]; then
    echo "Unable to identify device id..."
else
    enabledId=$(xinput --list-props $touchPadId | grep -i enabled | sed 's/.*(//' | sed 's/).*//')
    #echo Property ID: $enabledId
    status=$(xinput --list-props $touchPadId | grep -i enabled | sed 's/.*://')
    #echo Status: $status 
    if [ $status = 0 ]; then
        xinput set-prop $touchPadId $enabledId 1
        echo Trackpad Enabled
    else
        xinput set-prop $touchPadId $enabledId 0
        echo Trackpad Disabled
    fi
fi

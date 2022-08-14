#!/bin/bash
termux-sensor -c
SENSORDATA=`termux-sensor -d 100 -n 10 -s "TILT_DETECTOR" | jq '.TILT_DETECTOR.values[0]'`
if [ "$SENSORDATA" != "" ];
then
    echo $SENSORDATA
fi

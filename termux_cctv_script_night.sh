#!/bin/sh
USER=`whoami`
termux-torch on && termux-camera-photo -c 0 ~/storage/cctv/${USER}/C0_"$(date +"%Y_%m_%d_%I_%M_%S_%p").png"
termux-camera-photo -c 1 ~/storage/cctv/${USER}/C1_"$(date +"%Y_%m_%d_%I_%M_%S_%p").png"
termux-torch off
termux-microphone-record -f ~/storage/cctv/${USER}/AU_"$(date +"%Y_%m_%d_%I_%M_%S_%p").aac" -e aac -l 10
find ~/storage/cctv/${USER} -type f -mtime +5 -delete


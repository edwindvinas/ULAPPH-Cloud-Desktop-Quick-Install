#!/bin/sh
USER=`whoami`
termux-camera-photo -c 0 ~/storage/external-1/cctv/${USER}/C0_"$(date +"%Y_%m_%d_%I_%M_%S_%p").png"
#termux-camera-photo -c 1 ~/storage/external-1/cctv/${USER}/C1_"$(date +"%Y_%m_%d_%I_%M_%S_%p").png"
termux-microphone-record -f ~/storage/external-1/cctv/${USER}/AU_"$(date +"%Y_%m_%d_%I_%M_%S_%p").aac" -e aac -l 10
find ~/storage/external-1/cctv/${USER} -type f -mtime +5 -delete



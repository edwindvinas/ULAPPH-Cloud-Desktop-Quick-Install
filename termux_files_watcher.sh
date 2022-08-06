#!/bin/sh

if mkdir ~/mylock; then
  ( cd /data/data/com.termux/files/home/storage/shared/DCIM/Camera; find . -type f -mmin +2 ) | /data/data/com.termux/files/home/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-Quick-Install/termux_index_android_files.sh
  rmdir ~/mylock
else
  logger -p local0.notice "mylock found, skipping run"
fi


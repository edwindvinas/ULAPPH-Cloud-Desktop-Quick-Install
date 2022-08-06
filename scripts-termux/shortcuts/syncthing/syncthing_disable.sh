#!/data/data/com.termux/files/usr/bin/bash
echo "Stopping syncthing..."
ps aux | grep syncthing | grep -v "grep syncthing" | awk '{print $2}' | xargs kill -9
ps aux | grep syncthing | grep -v "grep syncthing" | awk '{print $2}' | xargs kill -9
termux-notification-remove "syncthingstarted"


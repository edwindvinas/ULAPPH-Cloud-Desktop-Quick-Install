#!/data/data/com.termux/files/usr/bin/bash
echo "Stopping ulapph..."
ps aux | grep ULAPPH-Cloud-Desktop | grep -v "grep ULAPPH-Cloud-Desktop" | awk '{print $2}' | xargs kill -9
ps aux | grep main | grep -v "grep main" | awk '{print $2}' | xargs kill -9
termux-notification-remove "ulapphstarted"

echo "Stopping syncthing..."
ps aux | grep syncthing | grep -v "grep syncthing" | awk '{print $2}' | xargs kill -9
ps aux | grep syncthing | grep -v "grep syncthing" | awk '{print $2}' | xargs kill -9
termux-notification-remove "syncthingstarted"

echo "Stopping filebrowser..."
ps aux | grep filebrowser | grep -v "grep filebrowser" | awk '{print $2}' | xargs kill -9
ps aux | grep filebrowser | grep -v "grep filebrowser" | awk '{print $2}' | xargs kill -9
termux-notification-remove "filebrowserstarted"

echo "Stopping fingerprint..."
ps aux | grep fingerprint | grep -v "grep fingerprint" | awk '{print $2}' | xargs kill -9

echo "Stopping speak..."
ps aux | grep speak | grep -v "grep speak" | awk '{print $2}' | xargs kill -9

echo "Stopping termux-api..."
ps aux | grep termux-api | grep -v "grep termux-api" | awk '{print $2}' | xargs kill -9

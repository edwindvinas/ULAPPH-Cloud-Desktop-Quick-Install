#!/data/data/com.termux/files/usr/bin/bash
echo "Stopping filebrowser..."
ps aux | grep filebrowser | grep -v "grep filebrowser" | awk '{print $2}' | xargs kill -9
ps aux | grep filebrowser | grep -v "grep filebrowser" | awk '{print $2}' | xargs kill -9
termux-notification-remove "filemgrstarted"

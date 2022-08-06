#!/data/data/com.termux/files/usr/bin/bash

echo "Enabling/adding crontab..."
crontab /data/data/com.termux/files/home/.shortcuts/commands/crontab.txt
crontab -l


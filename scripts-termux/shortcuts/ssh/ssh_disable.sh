#!/data/data/com.termux/files/usr/bin/bash
echo "Stopping sshd..."
ps aux | grep sshd | grep -v "grep sshd" | awk '{print $2}' | xargs kill -9
ps aux | grep sshd | grep -v "grep sshd" | awk '{print $2}' | xargs kill -9
termux-notification-remove "sshdstarted"

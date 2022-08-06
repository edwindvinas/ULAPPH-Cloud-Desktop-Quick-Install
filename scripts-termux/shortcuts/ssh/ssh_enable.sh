#!/data/data/com.termux/files/usr/bin/bash
TERMUX_HOME=/data/data/com.termux/files/home
THIS_IP=`${TERMUX_HOME}/go/bin/getip`
echo "Running sshd..."
termux-notification -t "SSH Started" -c "ssh -p 8022 ${THIS_IP}" --ongoing --id "sshstarted"
sshd &


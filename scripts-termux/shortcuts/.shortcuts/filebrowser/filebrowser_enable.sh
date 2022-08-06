#!/data/data/com.termux/files/usr/bin/bash
TERMUX_HOME=/data/data/com.termux/files/home
THIS_IP=`${TERMUX_HOME}/go/bin/getip`
echo "Running filebrowser..."
termux-notification -t "FileManager Started" -c "IP ADDRESS: http://${THIS_IP}:9090/" --ongoing --id "filemgrstarted"
/data/data/com.termux/files/usr/bin/filebrowser -p 9090 -a ${THIS_IP} -r "${TERMUX_HOME}/storage/ulapph/ulapph-data/" &
echo "Open in browser..."
if which xdg-open > /dev/null
then
  xdg-open http://${THIS_IP}:9090
elif which gnome-open > /dev/null
then
  gnome-open http://${THIS_IP}:9090
fi


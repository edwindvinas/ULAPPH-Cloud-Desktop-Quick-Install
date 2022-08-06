#!/data/data/com.termux/files/usr/bin/bash
TERMUX_HOME=/data/data/com.termux/files/home
THIS_IP=`${TERMUX_HOME}/go/bin/getip`
echo "Running syncthing..."
termux-notification -t "Syncthing Started" -c "IP ADDRESS: http://${THIS_IP}:8384/" --ongoing --id "syncthingstarted"
/data/data/com.termux/files/usr/bin/syncthing 1> /dev/null 2> /dev/null &
/data/data/com.termux/files/usr/bin/syncthing &

echo "Open in browser..."
if which xdg-open > /dev/null
then
  xdg-open https://${THIS_IP}:8384
elif which gnome-open > /dev/null
then
  gnome-open https://${THIS_IP}:8384
fi
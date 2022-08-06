#!/data/data/com.termux/files/usr/bin/bash

export GO111MODULE=off

alias dev='cd ~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop'
alias ai='cd ~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-AI'
alias ctl='cd ~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-CTL'
alias cfg='cd ~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-Configs'
alias dep='cd ~/go/src/github.com/edwindvinas/ULAPPH-Android-Desktop-Quick-Install'
alias deploy-android='cd ~/go/src/github.com/edwindvinas/ULAPPH-Android-Desktop-Quick-Install && ./*ANDROID*'

export TERMUX_HOME=/data/data/com.termux/files/home
export GOPATH=$PATH:${TERMUX_HOME}/go
export PATH=$PATH:${TERMUX_HOME}/go/bin

GOPATH=${TERMUX_HOME}/go
DATA_HOME=/data/data/com.termux/files/home/storage/ulapph
#-------------TIEDOT DB-------
#echo "Stopping tiedot db..."
#curl "http://localhost:6060/shutdown"
#echo "Running tiedot db..."
#$GOPATH/bin/tiedot -mode=httpd -dir=$DATA_HOME/tiedot -port=6060 &
#echo "Indexing TDSMEDIA collection in tiedotDB..."
#curl "http://localhost:6060/index?col=TDSMEDIA&path=MEDIA_ID"
#curl "http://localhost:6060/index?col=TDSMEDIA&path=CATEGORY"
#curl "http://localhost:6060/index?col=TDSSLIDE&path=DOC_ID"
#curl "http://localhost:6060/index?col=TDSSLIDE&path=CATEGORY"
#curl "http://localhost:6060/index?col=TDSARTL&path=DOC_ID"
#curl "http://localhost:6060/index?col=TDSARTL&path=CATEGORY"
#-------------SEAWEEDFS-------
#echo "Stopping seaweedfs..."
#ps aux | grep weed | grep -v "grep weed" | awk '{print $2}' | xargs kill -9
#echo "Running SeaweedFS...master"
#$GOPATH/bin/weed master &
#echo "Running SeaweedFS...starting volume server 1..."
#$GOPATH/bin/weed volume -dir=$DATA_HOME/swfs -max=10  -mserver="localhost:9333" -port=7070 &
#-------------ULAPPH-------
echo "Stopping ulapph..."
ps aux | grep ULAPPH-Cloud-Desktop | grep -v "grep ULAPPH-Cloud-Desktop" | awk '{print $2}' | xargs kill -9
ps aux | grep main | grep -v "grep main" | awk '{print $2}' | xargs kill -9


THIS_IP=`${TERMUX_HOME}/go/bin/getip`
#echo $THIS_IP

echo "Starting ULAPPH server..."
termux-notification -t "ULAPPH Started" -c "IP ADDRESS: https://${THIS_IP}:8384/" --ongoing --id "ulapphstarted"
#./main 1> /dev/null 2> /dev/null &
cd ${TERMUX_HOME}/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop
./main &

echo "Open in browser..."
if which xdg-open > /dev/null
then
  xdg-open https://localhost:8334
elif which gnome-open > /dev/null
then
  gnome-open https://localhost:8334
fi


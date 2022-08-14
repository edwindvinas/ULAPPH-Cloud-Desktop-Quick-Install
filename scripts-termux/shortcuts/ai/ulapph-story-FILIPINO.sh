#!/data/data/com.termux/files/usr/bin/bash
echo "Setting API key..."
cd /data/data/com.termux/files/home/ && source ./export-api-keys.sh

API_KEY=$SPEECH_API_KEY
SPEECH_TIME=3
ULAPPH=~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop

#Check api key
echo $API_KEY
if [ "$API_KEY" == "" ];
then
    echo "================================="
    echo "ERROR: API Key not found!"
    echo "================================="
    echo "Please set it using the command export-api-keys.sh."
    exit 0
fi

termux-media-player play $ULAPPH/static/audio/water-drop.mp3 > /dev/null & #play start sound 
function callUlapphAssistant() {
    logger "callUlapphAssistant"
    url="https://localhost:8443/orch?oFunc=story&oMsg=${ENC_MESSAGE}&oUser=wyhc8lfah5cl74hj@gmail.com&oUI=isChatWindow&oWA=&oLoc=&oTS=2022-8-7"
    logger $url
    content=`curl $url -k | jq '.data'`
    logger $content
    echo $content
    arrIN=`echo $content | awk -F'UWM_ACTION' '{print $1}'`
    echo ${arrIN}
    fMessage=${arrIN}
    translateToFilipino ${fMessage}
    sayTextToAudioFil ${SPEECH}
    #Repeat loop
    dialogBoxConfirm
    if [ "$CONF" == "\"yes\"" ];
    then
        callUlapphAssistant
    else
        sayTextToAudioFil "Okay, paalam na muna sa ngayon." 
        sleep 5
        exit 0
    fi
}
translateToFilipino() {
    logger "translateToFilipino()"
    logger "$@"
    rawurlencode "$@"
    SPEECH=`curl -A "Mozilla/5.0" 'https://us-central1-ulapph-demo.cloudfunctions.net/function-1?FUNC_CODE=trans-to-fil&text='${ENC_MESSAGE}'&uid=wyhc8lfah5cl74hj@gmail.com&API_KEY='$API_KEY`
    echo ${SPEECH}
    if [ "$SPEECH" == "" ];
    then
        sayTextToAudioFil "Pasensya na po, di ko kayo maintindihan. Paalam na muna."
        exit 0
    fi
}
rawurlencode() {
  local string="$@"
  local strlen=${#string}
  local encoded=""
  local pos c o
  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER)
  ENC_MESSAGE="${encoded}"   #+or echo the result (EASIER)... or both... :p
}
function dialogBoxConfirm() {
    CONF=`termux-dialog confirm -i "Press Yes to speak again" -t "ULAPPH - Story - FILIPINO" | jq .text`
    echo $CONF
}
function sayTextToAudio() {
    logger "sayTextToAudio()"
    termux-tts-speak $@ 
}
function sayTextToAudioFil() {
    logger "sayTextToAudioFil()"
    IN_MSG=$@
    sayInData=`echo ${IN_MSG} | sed "s/\&quot\;//g"`
    echo $sayInData
    termux-tts-speak -l "fil-PH" $sayInData
}
function logger() {
    if [ "$FL_LOGGER_ON" == "Y" ];
    then
        termux-toast "$@"
    fi
}
callUlapphAssistant

#!/data/data/com.termux/files/usr/bin/bash
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

mic_listen() {
    logger "mic_listen()"
    rm -f ../tmp.mp4
    rm -f ../tmp.wav
    termux-media-player play $ULAPPH/static/audio/water-drop.mp3 > /dev/null & #play start sound 
    logger "termux-microphone-record"
    OUTPUT="$(termux-microphone-record -f ../tmp.mp4 -l $SPEECH_TIME -r 16000 -c 1 -e amr_nb)"
    if [[ "$OUTPUT" =~ "Recording error: null" ]]; then
        termux-notification --sound -t "Speech Recognition Error" -c "Can't access the mic. Make sure not other app is using the mic."
        exit
    fi
}
recordAndUploadAudio() {
    logger "recordAndUploadAudio()"
    termux-microphone-record -q > /dev/null
    ffmpeg -loglevel panic -i ../tmp.mp4 -f wav -bitexact -acodec pcm_s16le -ar 16000 -ac 1 ../tmp.wav
    rm -f ../tmp.mp4
    logger "termux-media-player"
    termux-media-player play ../tmp.wav > /dev/null & #play recording back before deepspeech
    #rm -f ../tmp.wav
    ls -la ../tmp.wav
    RESP=`curl -F "file=@../tmp.wav;type=audio/x-wav" -A "Mozilla/5.0" 'https://us-central1-ulapph-demo.cloudfunctions.net/function-1?FUNC_CODE=upload-audio&uid=wyhc8lfah5cl74hj@gmail.com&API_KEY='$API_KEY`
    echo ${RESP}
    recognizeAudio
}
recognizeAudio() {
    logger "recognizeAudio()"
    SPEECH=`curl -A "Mozilla/5.0" 'https://us-central1-ulapph-demo.cloudfunctions.net/function-1?FUNC_CODE=speech-to-text-fil&fileURI='${RESP}'&uid=wyhc8lfah5cl74hj@gmail.com&API_KEY='$API_KEY`
    echo ${SPEECH}
    if [ "$SPEECH" == "" ];
    then
        sayTextToAudioFil "Paumanhin po, di ka nagbigay ng tamang salita. Paalam na muna."
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
        sayTextToAudioFil "Pasensya na po, di ko kau maintindihan. Paalam na muna."
        exit 0
    fi
}
function openURL() {
    echo "Open in browser..."
    NEW_URL=$@
    URL_IN=`echo $@ | awk -F'https' '{print $2}'`
    if [ "$URL_IN" == "" ];
    then
        NEW_URL="https://localhost:8443"$@
        echo $NEW_URL
    fi
    if which xdg-open > /dev/null
    then
        xdg-open $NEW_URL
    elif which gnome-open > /dev/null
    then
        gnome-open $NEW_URL
    fi
}

function callUlapphAssistant() {
    logger "callUlapphAssistant"
    logger "$@"
    rawurlencode "$@"
    echo $ENC_MESSAGE
    url="https://localhost:8443/orch?oFunc=iwa&oMsg=${ENC_MESSAGE}&oUser=wyhc8lfah5cl74hj@gmail.com&oUI=isChatWindow&oWA=&oLoc=&oTS=2022-8-7"
    logger $url
    content=`curl $url -k | jq '.data'`
    logger $content
    echo $content
    arrIN=`echo $content | awk -F'UWM_ACTION' '{print $1}'`
    echo ${arrIN}
    fMessage=${arrIN}
    translateToFilipino ${fMessage}
    sayTextToAudioFil ${SPEECH}
    #Open any window is indicated
    arrIN2=`echo $content | awk -F'UWM_ACTION::OPENWINDOW::' '{print $2}'`
    echo $arrIN2
    FURL=`echo ${arrIN2} | tr -d '"'`
    echo $FURL
    if [ "$FURL" != "" ];
    then
        logger "Opening url..."
        sayTextToAudioFil "Ang app ay binubuksan na at hanggang dito na lang muna ako..."
        openURL $FURL
        exit 0
    fi
    #Open any tab is indicated
    arrIN3=`echo $content | awk -F'UWM_ACTION::OPENTAB::' '{print $2}'`
    echo $arrIN3
    FURL2=`echo ${arrIN3} | tr -d '"'`
    echo $FURL2
    if [ "$FURL2" != "" ];
    then
        logger "Opening url..."
        sayTextToAudioFil "Ang app ay binubuksan na at hanggang dito na lang muna ako..."
        openURL $FURL2
        exit 0
    fi
    #Repeat loop
    dialogBoxConfirm
    if [ "$CONF" == "\"yes\"" ];
    then
        mic_listen
        sleep $SPEECH_TIME
        recordAndUploadAudio
        callUlapphAssistant $SPEECH
    else
        sayTextToAudioFil "Okay, paalam na muna sa ngayon." 
        sleep 5
        exit 0
    fi
}
function dialogBoxConfirm() {
    CONF=`termux-dialog confirm -i "Pindutin ang Yes para magsalita ulit." -t "ULAPPH Speak - FILIPINO" | jq .text`
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
    sayInData2=`echo ${sayInData} | sed "s/h\\n//g"`
    sayInData3=`echo ${sayInData2} | sed "s/m\\n//g"`
    echo $sayInData3
    termux-tts-speak -l "fil-PH" $sayInData3
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
function logger() {
    if [ "$FL_LOGGER_ON" == "Y" ];
    then
        termux-toast "$@"
    fi
}
mic_listen
sleep $SPEECH_TIME
recordAndUploadAudio
callUlapphAssistant $SPEECH

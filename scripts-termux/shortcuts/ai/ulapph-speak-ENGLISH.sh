#!/data/data/com.termux/files/usr/bin/bash
API_KEY=YOUR-API-KEY
SPEECH_TIME=3
ULAPPH=~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop
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
    SPEECH=`curl -A "Mozilla/5.0" 'https://us-central1-ulapph-demo.cloudfunctions.net/function-1?FUNC_CODE=speech-to-text&fileURI='${RESP}'&uid=wyhc8lfah5cl74hj@gmail.com&API_KEY='$API_KEY`
    echo ${SPEECH}
    if [ "$SPEECH" == "" ];
    then
        sayTextToAudio "Sorry, you have entered blank message, bye for now."
        exit 0
    fi
}
function openURL() {
    echo "Open in browser..."
    if which xdg-open > /dev/null
    then
      xdg-open $@
    elif which gnome-open > /dev/null
    then
      gnome-open $@
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
    sayTextToAudio ${fMessage}
    #Open any window is indicated
    arrIN2=`echo $content | awk -F'UWM_ACTION::OPENWINDOW::' '{print $2}'`
    echo $arrIN2
    FURL=`echo ${arrIN2} | tr -d '"'`
    if [ "$FURL" != "" ];
    then
        echo "Opening url..."
        sayTextToAudio "Opening URL and exiting..."
        openURL $FURL
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
        sayTextToAudio "Ok, bye for now."
        sleep 5
        exit 0
    fi
}

function dialogBoxConfirm() {
    CONF=`termux-dialog confirm -i "Press Yes to speak again" -t "ULAPPH AI English - Voice" | jq .text`
    echo $CONF
}
function sayTextToAudio() {
    logger "sayTextToAudio()"
    termux-tts-speak $@ 
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

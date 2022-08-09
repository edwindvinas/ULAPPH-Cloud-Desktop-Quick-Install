#!/data/data/com.termux/files/usr/bin/bash
echo "======================="
echo "Welcome to ULAPPH Chat"
echo "======================="
#------------------------------------------------------------
FL_LOGGER_ON=N
CURL=/data/data/com.termux/files/usr/bin/curl
ULAPPH=~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop
WELCOME="Hi, I'm Ulap Bot! You can talk to me by typing your message in the chat box. What can I do for you?"
#------------------------------------------------------------
function popMessageTone() {
    logger "popMessageTone()"
    termux-media-player play $ULAPPH/static/audio/water-drop.mp3 > /dev/null & #play start sound
}
function sayTextToAudio() {
    logger "sayTextToAudio()"
    termux-tts-speak $@ 
}
function youSaidTextToAudio() {
    logger "youSaidTextToAudio"
    termux-tts-speak "You said: " $@ 
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
}
function dialogBoxInput() {
    INPUT=`termux-dialog text -i "Enter message" -t "ULAPPH AI Chat" | jq .text`
}
function logger() {
    if [ "$FL_LOGGER_ON" == "Y" ];
    then
        termux-toast "$@"
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
function runMainLogic() {
    popMessageTone
    dialogBoxInput
    FINPUT=`echo ${INPUT} | tr -d '"'`
    echo $FINPUT
    if [ "$FINPUT" == "" ];
    then
        sayTextToAudio "Sorry, you have entered blank input, bye for now."
        exit 0
    fi
    youSaidTextToAudio ${FINPUT}
    callUlapphAssistant ${FINPUT}
    runMainLogic
}
runMainLogic

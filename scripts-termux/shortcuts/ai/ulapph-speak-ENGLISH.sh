#!/data/data/com.termux/files/usr/bin/bash
API_KEY=YOUR-API-KEY
SPEECH_TIME=3
ULAPPH=~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop
NORESPCTR=0
#Check api key
echo $API_KEY
if [ "$API_KEY" == "YOUR-API-KEY" ]; 
then
    echo "ERROR: API Key not found!"
    echo "Please enter it in the dialog box."
    dialogBoxApiKeyInput
    echo "Updating API keys in different files..."
    cd /data/data/com.termux/files/home/.shortcuts/ai/
    sed -i 's/API_KEY=YOUR-API-KEY/API_KEY='${API_KEY_INPUT}'/g' *
fi
function dialogBoxApiKeyInput() {
    API_KEY_INPUT=`termux-dialog text -i "Enter API Key" -t "ULAPPH AI - API Key" | jq .text`
}

mic_listen() {
    logger "mic_listen()"
    rm -f ../tmp.mp4
    rm -f ../tmp.wav
    #termux-media-player play $ULAPPH/static/audio/water-drop.mp3 > /dev/null & #play start sound 
    termux-media-player play $ULAPPH/static/audio/sonar.mp3 > /dev/null & #play start sound 
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
    #if [ "$SPEECH" == "" ];
    #then
    #    sayTextToAudio "Sorry, you have entered blank message."
    #fi
}
function openURL() {
    echo "Open in browser..."
    NEW_URL=$@
    URL_IN=`echo $@ | awk -F'https' '{print $2}'`
    echo $URL_IN
    if [ "$URL_IN" == "" ]; 
    then
        NEW_URL="https://localhost:8443"$@
        echo $NEW_URL
    fi
    if which xdg-open > /dev/null
    then
        xdg-open "$NEW_URL"
    elif which gnome-open > /dev/null
    then
        gnome-open "$NEW_URL"
    fi
}
function sendSmsMessage() {
    logger "sendSmsMessage()"
    SENDSTAT=`termux-sms-send -n $SMS_NUM -s 1 $SPEECH | jq '.'`
    echo $SENDSTAT
}
function callTelephoneNumber() {
    logger "callTelephoneNumber()"
    CALLSTAT=`termux-telephony-call $@`
    echo $CALL_STAT
}
function pauseAiListener() {
    echo "Pausing AI listener..."
    sayTextToAudio "Pausing AI listener... To resume, please raise it again!"
    STATUS_FILE="/data/data/com.termux/files/home/.shortcuts/ai/STATUS.txt"
    rm $STATUS_FILE 
    touch $STATUS_FILE 
    echo "SILENCED" > $STATUS_FILE
    SOUND="/data/data/com.termux/files/home/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop/static/audio/kewl.wav"
    termux-media-player play $SOUND
    ps aux | grep "ulapph-speak-ENGLISH.sh" | grep -v "grep ulapph-speak-ENGLISH.sh" | awk '{print $2}' | xargs kill -9
    #exit 0
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
    #FURL=`echo ${FURL} | tr -d '::'`
    echo $FURL
    if [ "$FURL" != "" ];
    then
        echo "Opening url..."
        #sayTextToAudio "Opening URL and exiting..."
        openURL $FURL
        sleep 15
        #exit 0
    fi
    #Open any tab is indicated
    arrIN3=`echo $content | awk -F'UWM_ACTION::OPENTAB::' '{print $2}'`
    echo $arrIN3
    FURL2=`echo ${arrIN3} | tr -d '"'`
    #FURL2=`echo ${FURL2} | tr -d '::'`
    echo $FURL2
    if [ "$FURL2" != "" ];
    then
        echo "Opening url..."
        #sayTextToAudio "Opening URL and exiting..."
        openURL $FURL2
        #exit 0
    fi
    #Open link before speaking
    #sayTextToAudio ${fMessage}

    #If reading SMS messages, ask if SMS will be sent
    arrIN4=`echo $content | awk -F'UWM_ACTION::SENDSMS::' '{print $2}'`
    echo $arrIN4
    SMS_NUM=`echo ${arrIN4} | tr -d '::'`
    SMS_NUM=`echo ${SMS_NUM} | tr -d '"'`
    echo $SMS_NUM
    if [ "$SMS_NUM" != "" ];
    then
        echo "Getting text message..."
        sayTextToAudio "If you want to reply, please say your message at the tone."
        mic_listen
        sleep $SPEECH_TIME
        recordAndUploadAudio
        if [ "$SPEECH" != "" ];
        then
            echo "Sending Text Message..."
            sayTextToAudio "Sending text message!"
            sendSmsMessage
            sayTextToAudio "SMS text message has been sent!"
            #sleep 5
            #exit 0
        else
            echo "Would you like to read the next message?"
            sayTextToAudio "Would you like to read next message, say, read messages. If you would like to read from latest, say, read messages from start. Or you can ask me anything."
            mic_listen
            sleep $SPEECH_TIME
            recordAndUploadAudio
            callUlapphAssistant $SPEECH 
        fi
    fi
    #Process phone call intent
    #UWM_ACTION::CALL_CONTACT::09175912244
    callNumIntent=`echo $content | awk -F'UWM_ACTION::CALL_CONTACT::' '{print $2}'`
    echo $callNumIntent
    CALL_NUM=`echo ${callNumIntent} | tr -d '::'`
    CALL_NUM=`echo ${CALL_NUM} | tr -d '"'`
    echo $CALL_NUM
    if [ "$CALL_NUM" != "" ];
    then
        echo "Call phone number..."
        sayTextToAudio "Dialing phone number $CALL_NUM"
        callTelephoneNumber $CALL_NUM
        echo "Pausing AI listener before calling..."
        pauseAiListener
    fi

    # If stop AI bot
    STOP_AI=`echo $content | awk -F'UWM_ACTION::STOP_AI::' '{print $2}'`
    echo $STOP_AI
    if [ "$STOP_AI" != "" ];
    then
        echo "Pausing AI listener..."
        pauseAiListener
    fi

    # If motd
    MOTD=`echo $content | awk -F'UWM_ACTION::MOTD::' '{print $2}'`
    echo $MOTD
    if [ "$MOTD" != "" ];
    then
        echo "Getting motd..."
        url="https://localhost:8443/orch?oFunc=motd&oMsg=${MOTD}&oUser=wyhc8lfah5cl74hj@gmail.com&oUI=isChatWindow&oWA=&oLoc=&oTS=2022-8-7"
        logger $url
        content=`curl $url -k | jq '.data'`
        logger $content
        echo $content
        arrIN=`echo $content | awk -F'UWM_ACTION' '{print $1}'`
        echo ${arrIN}
        fMessage=${arrIN}
        sayTextToAudio ${fMessage}
    fi

    # If story 
    STORY=`echo $content | awk -F'UWM_ACTION::STORY::' '{print $2}'`
    echo $STORY
    if [ "$STORY" != "" ];
    then
        echo "Getting story..."
        url="https://localhost:8443/orch?oFunc=story&oMsg=${STORY}&oUser=wyhc8lfah5cl74hj@gmail.com&oUI=isChatWindow&oWA=&oLoc=&oTS=2022-8-7"
        logger $url
        content=`curl $url -k | jq '.data'`
        logger $content
        echo $content
        arrIN=`echo $content | awk -F'UWM_ACTION' '{print $1}'`
        echo ${arrIN}
        fMessage=${arrIN}
        sayTextToAudio ${fMessage}
    fi

    sayTextToAudio "Would you like to try another one, you can ask me again."
    mic_listen
    sleep $SPEECH_TIME
    recordAndUploadAudio
    callUlapphAssistant $SPEECH 

    #dialogBoxConfirm
    #if [ "$CONF" == "\"yes\"" ];
    #then
    #    mic_listen
    #    sleep $SPEECH_TIME
    #    recordAndUploadAudio
    #    callUlapphAssistant $SPEECH
    #else
    #    sayTextToAudio "Ok, bye for now."
    #    sleep 5
    #    exit 0
    #fi
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

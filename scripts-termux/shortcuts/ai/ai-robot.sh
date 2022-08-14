#!/data/data/com.termux/files/usr/bin/bash
FL_LOGGER_ON=N

function logger() {
    if [ "$FL_LOGGER_ON" == "Y" ];
    then
        termux-toast "$@"
    fi
}

function sayTextToAudio() {
    logger "sayTextToAudio()"
    termux-tts-speak $@
}

function dialogBoxConfirm() {
    CONF=`termux-dialog confirm -i "Press Yes to display intents list." -t "ULAPPH AI" | jq .text`
    echo $CONF
}

echo "Running Ulaph AI robot in the background..."
logger "Running Ulaph AI robot in the background..."
SOUND="/data/data/com.termux/files/home/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop/static/audio/startup.mp3"
termux-media-player play $SOUND

sayTextToAudio "Hello, welcome to Ulap AI Robot!"
sayTextToAudio "Do you want to know the sample intents?"

dialogBoxConfirm
if [ "$CONF" == "\"yes\"" ];
then
    logger "Displaying intents list..."
    sayTextToAudio "Here are the intents recognized by Ulap AI Robot!"
    INTENTS=$(cat /data/data/com.termux/files/home/.shortcuts/ai/INTENTS.txt)
    echo $INTENTS
    sayTextToAudio $INTENTS
fi

logger "Please activate the bot by raising your phone."
sayTextToAudio "Please activate the bot by raising your phone."

logger "Running acc_detector.sh..."
/data/data/com.termux/files/home/.shortcuts/sensors/acc_detector.sh



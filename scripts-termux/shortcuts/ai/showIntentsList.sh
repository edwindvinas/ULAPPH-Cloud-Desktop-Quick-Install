#!/data/data/com.termux/files/usr/bin/bash

FL_LOGGER_ON=N

INTENTS=$(cat /data/data/com.termux/files/home/.shortcuts/ai/INTENTS.txt)

function logger() {
    if [ "$FL_LOGGER_ON" == "Y" ];
    then
        termux-toast "$@"
    fi
}

termux-dialog text -m -i "${INTENTS}" -t "ULAPPH AI Intents"


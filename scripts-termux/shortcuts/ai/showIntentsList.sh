#!/data/data/com.termux/files/usr/bin/bash

FL_LOGGER_ON=N

INTENTS=$(cat <<-END
quote of the day,
quotation,
define word,
definition for word,
dictionary word,
dictionary for word,
word of the day,
joke,
tell me a joke,
news latest,
news Philippines,
news technology,
what is term,
what is a term,
what is an term,
who is term,
what is the term,
wiki for term,
wikipedia for term,
wikipedia term,
bible,
play,
play lords prayer,
lords prayer,
play funny,
play mario,
play tetris,
play word game,
play text twist,
play game,
watch youtube,
launch youtube,
music,
play sound,
play sounds,
play song,
play music,
play video,
youtube,
listen radio,
play radio,
play music,
play video,
quick search,
search,
search,
quotation,
news live stream,
open article-,
open slide-,
open media-,
open ARTICLE-,
open SLIDE-,
open MEDIA-,
END
)

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

termux-dialog text -m -i "${INTENTS}" -t "Sample Intents" &
sayTextToAudio ${INTENTS}


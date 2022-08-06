#!/bin/bash
SPEECH_TIME=2
ULAPPH=~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop
mic_listen() {
    rm -f ../tmp.mp4
    rm -f ../tmp.wav
    termux-media-player play $ULAPPH/water-drop.mp3 > /dev/null & #play start sound 
    OUTPUT="$(termux-microphone-record -f ../tmp.mp4 -l $SPEECH_TIME -r 16000 -c 1 -e amr_nb)"
    if [[ "$OUTPUT" =~ "Recording error: null" ]]; then
        termux-notification --sound -t "Speech Recognition Error" -c "Can't access the mic. Make sure not other app is using the mic."
        exit
    fi

}
uploadToRecognize() {
    termux-microphone-record -q > /dev/null
    ffmpeg -loglevel panic -i ../tmp.mp4 -f wav -bitexact -acodec pcm_s16le -ar 16000 -ac 1 ../tmp.wav
    rm -f ../tmp.mp4
    termux-media-player play ../tmp.wav > /dev/null & #play recording back before deepspeech

    #rm -f ../tmp.wav
    ls -la ../tmp.wav

    curl -F "file=@../tmp.wav;type=audio/x-wav" -A "Mozilla/5.0" 'https://www.ulapph.com/stt?FUNC_CODE=upload&UID=wyhc8lfah5cl74hj@gmail.com'
}

mic_listen
sleep $SPEECH_TIME
uploadToRecognize



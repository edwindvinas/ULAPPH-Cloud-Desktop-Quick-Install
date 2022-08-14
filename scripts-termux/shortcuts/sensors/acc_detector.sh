#!/data/data/com.termux/files/usr/bin/bash
echo "Setting env vars..."
cd /data/data/com.termux/files/home && source ./export-api-keys.sh

PREV_STATE="DEACTIVATED"
FL_LOGGER_ON=N
SENSOR_NAME=""

function logger() {
    if [ "$FL_LOGGER_ON" == "Y" ];
    then
        termux-toast "$@"
    fi
}

#Get acceloremeter sensor name
logger "Getting acceloremeter sensor name from env variable..."
SENSOR_NAME=$SENSOR_ACC_NAME
echo $SENSOR_NAME
if [ "$SENSOR_NAME" == "" ];
then
    logger "ERROR: SENSOR_NAME is not defined!"
    echo "ERROR: SENSOR_NAME is not defined!"
    echo "Please set from the ~/export-api-keys.sh in order to set env var..."
    echo "Aborted. Please fix the issue first."
    exit 0
fi

while :
do
    logger "termux-sensor -c"
    termux-sensor -c
    logger "termux-sensor -d 100 -n 10 -s \"${SENSOR_NAME}\""
    SENSORDATA=`termux-sensor -d 100 -n 10 -s "${SENSOR_NAME}" | jq .${SENSOR_NAME}.values[0]`
    if [ "$SENSORDATA" != "" ];
    then
        echo $SENSORDATA
        #logger "SENSORDATA: $SENSORDATA"
        TOTAL=`echo 0 + 0 | bc`
        logger "TOTAL: $TOTAL"
        for i in $SENSORDATA
        do
          :
          # do whatever on $i
          #echo "VALUE: "$i
          TOTAL=`echo $TOTAL + $i | bc`
        done
        echo "TOTAL: ${TOTAL}"
        logger "TOTAL: $TOTAL"
        logger "PREV_STATE: $PREV_STATE"
        if (( $(echo "$TOTAL > 1" | bc -l) )); then
            #Status file can tell if AI was silenced previously
            logger "Status file can tell if AI was silenced previously"
            STATUS_FILE="/data/data/com.termux/files/home/.shortcuts/ai/STATUS.txt"
            if test -f "$STATUS_FILE"; then
                echo "$STATUS_FILE exists."
                STATUS_FILE_CONT=`cat $STATUS_FILE`
                logger "STATUS_FILE_CONT: $STATUS_FILE_CONT"
                echo $STATUS_FILE_CONT
                if [ "$STATUS_FILE_CONT" == "SILENCED" ];
                then
                    echo "AI Bot was previously silenced. Re-enabling AI."
                    #SOUND="/data/data/com.termux/files/home/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop/static/audio/baby2.mp3"
                    SOUND="/data/data/com.termux/files/home/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop/static/audio/R2D2e.mp3"
                    termux-media-player play $SOUND
                    PREV_STATE="ACTIVATED"
                    termux-vibrate -f -d 500
                    /data/data/com.termux/files/home/.shortcuts/ai/ulapph-speak-ENGLISH.sh
                    rm STATUS_FILE
                    touch STATUS_FILE
                fi
            fi

            if [ "$PREV_STATE" != "ACTIVATED" ];
            then
                echo "Phone was raised. Enabling AI."
                SOUND="/data/data/com.termux/files/home/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop/static/audio/R2D2e.mp3"
                #SOUND="/data/data/com.termux/files/home/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop/static/audio/baby2.mp3"
                termux-media-player play $SOUND
                PREV_STATE="ACTIVATED"
                termux-vibrate -f -d 500
                /data/data/com.termux/files/home/.shortcuts/ai/ulapph-speak-ENGLISH.sh
            fi
        fi
    fi
    sleep 2
    logger "Looping acc_detector..."
done

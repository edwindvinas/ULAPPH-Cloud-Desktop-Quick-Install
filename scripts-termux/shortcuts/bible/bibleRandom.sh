#!/data/data/com.termux/files/usr/bin/bash

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

INPUT=`termux-dialog radio -v "Bible Random Audio","Bible Audio","Bible Random Verse" -t "To God Be the Glory" | jq .text`
echo $INPUT
#sleep 5

if [ "$INPUT" == "\"Bible Random Audio\"" ];
then
    echo $INPUT
    BRA_URL='https://localhost:8443/bible?BIB_FUNC=biblegateway'
    openURL $BRA_URL
else
    if [ "$INPUT" == "\"Bible Audio\"" ];
    then
        echo $INPUT
        BA_URL='https://localhost:8443/bible?BIB_FUNC=biblegateway'
        openURL $BA_URL
    else
        if [ "$INPUT" == "\"Bible Random Verse\"" ];
        then
            echo $INPUT
            BRV_URL='https://randombibleizer.spiffy.tech/'
            openURL $BRV_URL
        else
            echo "Invalid choice"
            #sleep 5
        fi
    fi
fi

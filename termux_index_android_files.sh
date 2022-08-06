#!/bin/sh

HOME="/data/data/com.termux/files/home/storage/"
HOME_DATA="/data/data/com.termux/files/home/storage"
USER=`whoami`
echo $USER

INDEX_MUSIC="${HOME}/TERMUX_INDEX_MUSIC_FILES"
INDEX_VIDEO="${HOME}/TERMUX_INDEX_VIDEO_FILES"
INDEX_PICS="${HOME}/TERMUX_INDEX_PICS_FILES"
INDEX_MUSIC_TMP="${HOME}/TERMUX_INDEX_MUSIC_FILES.tmp"
INDEX_VIDEO_TMP="${HOME}/TERMUX_INDEX_VIDEO_FILES.tmp"
INDEX_PICS_TMP="${HOME}/TERMUX_INDEX_PICS_FILES.tmp"

rm ${INDEX_MUSIC_TMP} 1> /dev/null 2> /dev/null
rm ${INDEX_VIDEO_TMP} 1> /dev/null 2> /dev/null
rm ${INDEX_PICS_TMP} 1> /dev/null 2> /dev/null
touch ${INDEX_MUSIC_TMP} 1> /dev/null 2> /dev/null
touch ${INDEX_VIDEO_TMP} 1> /dev/null 2> /dev/null
touch ${INDEX_PICS_TMP} 1> /dev/null 2> /dev/null
chown $USER ${INDEX_MUSIC_TMP} 1> /dev/null 2> /dev/null
chown $USER ${INDEX_VIDEO_TMP} 1> /dev/null 2> /dev/null
chown $USER ${INDEX_PICS_TMP} 1> /dev/null 2> /dev/null
chgrp $USER ${INDEX_MUSIC_TMP} 1> /dev/null 2> /dev/null
chgrp $USER ${INDEX_VIDEO_TMP} 1> /dev/null 2> /dev/null
chgrp $USER ${INDEX_PICS_TMP} 1> /dev/null 2> /dev/null
chmod 777 ${INDEX_MUSIC_TMP} 1> /dev/null 2> /dev/null
chmod 777 ${INDEX_VIDEO_TMP} 1> /dev/null 2> /dev/null
chmod 777 ${INDEX_PICS_TMP} 1> /dev/null 2> /dev/null

echo "Finding all music files..."
termux-media-scan -v -r $HOME_DATA | grep ".ogg" > ${INDEX_MUSIC_TMP}
termux-media-scan -v -r $HOME_DATA | grep ".mp3" >> ${INDEX_MUSIC_TMP}
sleep 5
echo "Finding all video files..."
termux-media-scan -v -r $HOME_DATA | grep ".ogv" > ${INDEX_VIDEO_TMP}
termux-media-scan -v -r $HOME_DATA | grep ".mp4" >> ${INDEX_VIDEO_TMP}
sleep 5
echo "Finding all pics files..."
termux-media-scan -v -r $HOME_DATA | grep ".png" > ${INDEX_PICS_TMP}
termux-media-scan -v -r $HOME_DATA | grep ".jpg" >> ${INDEX_PICS_TMP}
sleep 5
echo "Fixing folder..."
#sed -i 's/\/storage\/emulated\/0/https\:\/\/192.168.1.51\:8443\/android\/shared/g' ${INDEX_MUSIC}
#sed -i 's/\/storage\/emulated\/0/https\:\/\/192.168.1.51\:8443\/android\/shared/g' ${INDEX_VIDEO}
#sed -i 's/\/storage\/emulated\/0/https\:\/\/192.168.1.51\:8443\/android\/shared/g' ${INDEX_PICS}
#sed -i 's/\/storage\/emulated\/0/\/android/g' ${INDEX_MUSIC}
#sed -i 's/\/storage\/emulated\/0/\/android/g' ${INDEX_VIDEO}
#sed -i 's/\/storage\/emulated\/0/\/android/g' ${INDEX_PICS}
sed -i 's/\/data\/data\/com.termux\/files\/home\/storage/\/android/g' ${INDEX_MUSIC_TMP} 1> /dev/null 2> /dev/null
sleep 5
sed -i 's/\/data\/data\/com.termux\/files\/home\/storage/\/android/g' ${INDEX_VIDEO_TMP} 1> /dev/null 2> /dev/null
sleep 5
sed -i 's/\/data\/data\/com.termux\/files\/home\/storage/\/android/g' ${INDEX_PICS_TMP} 1> /dev/null 2> /dev/null
sleep 5

mv ${INDEX_MUSIC_TMP} ${INDEX_MUSIC}
mv ${INDEX_VIDEO_TMP} ${INDEX_VIDEO}
mv ${INDEX_PICS_TMP} ${INDEX_PICS}
chown $USER ${INDEX_MUSIC} 1> /dev/null 2> /dev/null
chown $USER ${INDEX_VIDEO} 1> /dev/null 2> /dev/null
chown $USER ${INDEX_PICS} 1> /dev/null 2> /dev/null
chgrp $USER ${INDEX_MUSIC} 1> /dev/null 2> /dev/null
chgrp $USER ${INDEX_VIDEO} 1> /dev/null 2> /dev/null
chgrp $USER ${INDEX_PICS} 1> /dev/null 2> /dev/null

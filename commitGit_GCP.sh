#!/data/data/com.termux/files/usr/bin/bash

# commitGit_GCP.sh 202004120946PM

#cp ~/run_ulapph.sh ./scripts-termux
#cp ~/stop_ulapph.sh ./scripts-termux
#cp ~/update_ulapph.sh ./scripts-termux
cp ~/setalias_ulapph.sh ./scripts-termux/

#cp ~/.termux/boot/* ./scripts-termux-boot/

#cp ~/.shortcuts/tasks/*.sh ./scripts-termux-widget/
cp -r ~/.shortcuts/* ./scripts-termux/shortcuts/
sleep 2
git add --all
sleep 2
#echo $1
git commit -m "$1" 
sleep 2
#git push origin master
git push


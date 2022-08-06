#!/data/data/com.termux/files/usr/bin/bash

# commitGit_GCP.sh 202004120946PM

#cp ~/run_ulapph.sh ./scripts-termux
#cp ~/stop_ulapph.sh ./scripts-termux
#cp ~/update_ulapph.sh ./scripts-termux
cp ~/setalias_ulapph.sh ./scripts-termux/

#cp ~/.termux/boot/* ./scripts-termux-boot/

#cp ~/.shortcuts/tasks/*.sh ./scripts-termux-widget/
cp -r ~/.shortcuts/* ./scripts-termux/shortcuts

git add --all
git commit -m $1
git push origin master


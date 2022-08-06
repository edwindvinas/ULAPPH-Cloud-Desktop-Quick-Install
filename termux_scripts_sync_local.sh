#!/data/data/com.termux/files/usr/bin/bash

echo "Copying alias script..."
cp ./scripts-termux/setalias_ulapph.sh /data/data/com.termux/files/home/

echo "Copying shortcut scripts to ~/.shortcuts/..."
mkdir -p /data/data/com.termux/files/home/.shortcuts/
cp -r ./scripts-termux/shortcuts/* /data/data/com.termux/files/home/.shortcuts/
chmod 700 -R ~/.shortcuts/


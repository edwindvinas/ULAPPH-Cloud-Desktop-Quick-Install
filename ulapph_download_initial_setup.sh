#!/bin/bash
WORKDIR=~/go/src/github.com/edwindvinas/

echo "Creating initial go folders.."
mkdir ~/go
mkdir -p ~/go/src
mkdir -p ~/go/bin
mkdir -p ~/go/pkg
mkdir -p ~/go/src/github.com/edwindvinas/
export GOPTAH=~/go

echo "Downloading ULAPPH-Android-Desktop..."
cd $WORKDIR
git clone https://github.com/edwindvinas/ULAPPH-Android-Desktop.git 
cd ~/go/src/github.com/edwindvinas/
mv ULAPPH-Android-Desktop ULAPPH-Cloud-Desktop
cd ULAPPH-Cloud-Desktop/static/img/
mkdir wallpapers

echo "Downloading ULAPPH-Android-Desktop-AI..."
cd $WORKDIR 
git clone https://github.com/edwindvinas/ULAPPH-Cloud-Desktop-AI.git

echo "Downloading ULAPPH-Android-Desktop-Configs..."
cd $WORKDIR 
git clone https://github.com/edwindvinas/ULAPPH-Cloud-Desktop-Configs.git

echo "Downloading ULAPPH-Android-Desktop-Watson..."
cd $WORKDIR 

echo "Downloading ULAPPH-Android-Desktop-CTL..."
cd $WORKDIR 

echo "Downloading ULAPPH-Android-Desktop-WP..."
cd $WORKDIR 

echo "Downloading File Browser..."
cd $WORKDIR 
cd ULAPPH-Cloud-Desktop-Quick-Install
./termux_filebrowser_install.sh

echo "Download/Install Package Syncthing..."
pkg install syncthing


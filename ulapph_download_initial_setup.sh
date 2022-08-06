#!/bin/bash
#---------------------------------------------------------------------------
# Color scheme
# Reset
NC='\033[0m'       # Text Reset
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
#---------------------------------------------------------------------------

WORKDIR=~/go/src/github.com/edwindvinas/

echo -e "###############################################"
echo -e "${Yellow}Creating initial go folders..${NC}"
echo -e "###############################################"
mkdir ~/go
mkdir -p ~/go/src
mkdir -p ~/go/bin
mkdir -p ~/go/pkg
mkdir -p ~/go/src/github.com/edwindvinas/
export GOPTAH=~/go

echo -e "###############################################"
echo -e "${Yellow}Downloading ULAPPH-Android-Desktop...${NC}"
echo -e "###############################################"
cd $WORKDIR
git clone https://github.com/edwindvinas/ULAPPH-Android-Desktop.git 
cd ~/go/src/github.com/edwindvinas/
mv ULAPPH-Android-Desktop ULAPPH-Cloud-Desktop
cd ULAPPH-Cloud-Desktop/static/img/
mkdir wallpapers

echo -e "###############################################"
echo -e "${Yellow}Downloading ULAPPH-Android-Desktop-AI...${NC}"
echo -e "###############################################"
cd $WORKDIR 
git clone https://github.com/edwindvinas/ULAPPH-Cloud-Desktop-AI.git

echo -e "###############################################"
echo -e "${Yellow}Downloading ULAPPH-Android-Desktop-Configs...${NC}"
echo -e "###############################################"
cd $WORKDIR 
git clone https://github.com/edwindvinas/ULAPPH-Cloud-Desktop-Configs.git

echo -e "###############################################"
echo -e "Downloading ULAPPH-Android-Desktop-Watson..."
echo -e "###############################################"
cd $WORKDIR 
git clone https://github.com/edwindvinas/ULAPPH-Cloud-Desktop-Watson.git

echo -e "###############################################"
echo -e "Downloading ULAPPH-Android-Desktop-CTL..."
echo -e "###############################################"
cd $WORKDIR 
git clone https://github.com/edwindvinas/ULAPPH-Cloud-Desktop-CTL.git

echo -e "###############################################"
echo -e  "Downloading ULAPPH-Android-Desktop-WP..."
echo -e "###############################################"
cd $WORKDIR 
git clone https://github.com/edwindvinas/ULAPPH-Cloud-Desktop-WP.git

echo -e "###############################################"
echo -e  "Downloading File Browser..."
echo -e "###############################################"
cd $WORKDIR 
cd ULAPPH-Cloud-Desktop-Quick-Install
./termux_filebrowser_install.sh

echo -e "###############################################"
echo -e  "Download/Install Package Syncthing..."
echo -e "###############################################"
pkg install syncthing


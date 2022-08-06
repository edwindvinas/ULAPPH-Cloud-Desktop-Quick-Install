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
#---------------------------------------------------------------------------

echo -e "###############################################"
echo -e "${Yellow}Checking pre-requisites..${NC}"
echo -e "###############################################"
#TBD

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
echo -e "${Yellow}Copying scripts & go-bin folder..${NC}"
echo -e "###############################################"
echo -e "${Cyan}Copying alias script to ~...${NC}"
cp ./scripts-termux/setalias_ulapph.sh /data/data/com.termux/files/home/

echo -e "${Cyan}Copying shortcut scripts to ~/.shortcuts/...${NC}"
mkdir -p /data/data/com.termux/files/home/.shortcuts/
cp -r ./scripts-termux/shortcuts/* /data/data/com.termux/files/home/.shortcuts/
chmod 700 -R ~/.shortcuts/

echo "${Cyan}Copying go-bin/* to ~/go/bin/ ...${NC}"
cp ./go-bin/* /data/data/com.termux/files/home/go/bin/

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
echo -e "${Yellow}Downloading ULAPPH-Android-Desktop-Watson...${NC}"
echo -e "###############################################"
cd $WORKDIR 
git clone https://github.com/edwindvinas/ULAPPH-Cloud-Desktop-Watson.git

echo -e "###############################################"
echo -e "${Yellow}Downloading ULAPPH-Android-Desktop-CTL...${NC}"
echo -e "###############################################"
cd $WORKDIR 
git clone https://github.com/edwindvinas/ULAPPH-Cloud-Desktop-CTL.git

echo -e "###############################################"
echo -e  "${Yellow}Downloading ULAPPH-Android-Desktop-WP...${NC}"
echo -e "###############################################"
cd $WORKDIR 
git clone https://github.com/edwindvinas/ULAPPH-Cloud-Desktop-WP.git

echo -e "###############################################"
echo -e  "${Yellow}Installing termux API...${NC}"
echo -e "###############################################"
echo -e "${Cyan}Aside from Android apk, this CLI is needed for Termux API...${NC}"
pkg install termux-api

echo -e "###############################################"
echo -e  "${Yellow}Downloading File Browser...${NC}"
echo -e "###############################################"
cd $WORKDIR 
cd ULAPPH-Cloud-Desktop-Quick-Install
./termux_filebrowser_install.sh

echo -e "###############################################"
echo -e  "${Yellow}Download/Install Package Syncthing...${NC}"
echo -e "###############################################"
pkg install syncthing

echo -e "###############################################"
echo -e  "${Yellow}Initializing termux storage...${NC}"
echo -e "###############################################"
echo -e "${Cyan}Running termux-setup-storage...${NC}"
termux-setup-storage
echo -e "${Cyan}Creating initial ulapph-data folder...${NC}"
cd ~/storage/
mkdir ulapph
cd ~/storage/ulapph/
mkdir ulapph-data


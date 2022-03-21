#!/bin/bash
#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

RED='\033[0;31m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e ${CYAN}"====================================="
echo -e ${CYAN}"Welcome to ULAPPH Cloud Desktop!"
echo -e ${CYAN}"*** First-time setup script ***"
echo -e ${CYAN}"====================================="

echo "========================================"
THIS="ULAPPH-Cloud-Desktop"
THIS_ABOUT="ULAPP-Cloud-Desktop contains the Golang, JS, HTML, CSS codes"
THIS_GIT="https://github.com/edwindvinas/ULAPPH-Cloud-Desktop.git"
echo -e "${YELLOW}$THIS"
echo -e "${NC}$THIS_ABOUT"
echo -e "${NC}$THIS_GIT"
echo -e "${RED}Downloading...${NC}${CYAN} $THIS  ${NC}\n"
PWD=`pwd`
echo "Your Current Directory: " $PWD
MAIN=`cd .. && pwd`
echo "Will clone under Main Directory: " $MAIN
OLD=${MAIN}/${THIS}
echo "Removing old directory: " $OLD
rm -rf ${OLD}
cd $MAIN && git clone $THIS_GIT
echo -e "${GREEN}Downloaded... ${NC}${CYAN} $THIS  ${NC}\n"
echo "========================================"

echo "========================================"
THIS="ULAPPH-Cloud-Desktop-CTL"
THIS_ABOUT="ULAPP-Cloud-Desktop install controller"
THIS_GIT="https://github.com/edwindvinas/ULAPPH-Cloud-Desktop-CTL.git"
echo -e "${YELLOW}$THIS"
echo -e "${NC}$THIS_ABOUT"
echo -e "${NC}$THIS_GIT"
echo -e "${RED}Downloading...${NC}${CYAN} $THIS  ${NC}\n"

echo "Removing old directory: " $OLD
rm -rf ${THIS}
git clone $THIS_GIT
echo -e "${GREEN}Downloaded... ${NC}${CYAN} $THIS  ${NC}\n"

echo -e "${RED}Building...${NC}${CYAN} ulapphctl  ${NC}\n"
PWD=`pwd`
echo "Your Current Directory: " $PWD
cd $THIS && go build ulapphctl.go && ls -la
echo "Copying ulapphctl to GOBIN folder..."
cp ulapphctl ~/go/bin/
echo "Checking ulapphctl in GOBIN folder..."
ls -la ~/go/bin/ulapphctl
echo "========================================"

echo "========================================"
THIS="ULAPPH-Cloud-Desktop-Configs"
THIS_ABOUT="ULAPP-Cloud-Desktop-Configs contains YAML configurations"
THIS_GIT="https://github.com/edwindvinas/ULAPPH-Cloud-Desktop-Configs.git"
echo -e "${YELLOW}$THIS"
echo -e "${NC}$THIS_ABOUT"
echo -e "${NC}$THIS_GIT"
echo -e "${RED}Downloading...${NC}${CYAN} $THIS  ${NC}\n"

echo "Removing old directory: " $OLD
cd ..
rm -rf ${THIS}
git clone $THIS_GIT
echo -e "${GREEN}Downloaded... ${NC}${CYAN} $THIS  ${NC}\n"
echo "========================================"

#echo "========================================"
#THIS="ULAPPH-Cloud-Desktop"
#THIS_ABOUT="ULAPP-Cloud-Desktop initializing go mod"
#echo -e "${YELLOW}$THIS"
#echo -e "${RED}Initializing ...${NC}${CYAN} go mod  ${NC}\n"
#PWD=`pwd`
#echo "Your Current Directory: " $PWD
#cd $THIS
#PWD=`pwd`
#echo "Your Current Directory: " $PWD
#go mod init
#echo -e "${GREEN}Initialized... ${NC}${CYAN} go mod  ${NC}\n"
#echo "========================================"

#echo "========================================"
#THIS="ULAPPH-Cloud-Desktop"
#THIS_ABOUT="ULAPP-Cloud-Desktop installing dependencies"
#echo -e "${YELLOW}$THIS"
#echo -e "${RED}Installing ...${NC}${CYAN} dependencies  ${NC}\n"
#PWD=`pwd`
#echo "Your Current Directory: " $PWD
#cd $THIS && chmod +x gogetall.sh
#sed -i 's/go\ get\ /go\ get\ -u\ /' gogetall.sh 
#./gogetall.sh
#go mod tidy
#echo -e "${GREEN}Installed... ${NC}${CYAN} dependencies  ${NC}\n"
#echo "========================================"

echo "========================================"
THIS="ULAPPH-Cloud-Desktop-Quick-Install"
THIS_ABOUT="ULAPP-Cloud-Desktop installing in Docker"
echo -e "${YELLOW}$THIS"
echo -e "${RED}Installing server...${NC}${CYAN} ULAPPH in Docker  ${NC}\n"
PWD=`pwd`
echo "Your Current Directory: " $PWD
INS_SCRIPT=quick_install_ulapph_DOCKER_GENERIC.sh
cd $THIS && ./$INS_SCRIPT
#./$INS_SCRIPT
echo -e "${GREEN}Installed server... ${NC}${CYAN} ULAPPH in Docker  ${NC}\n"
echo "========================================"

#echo "========================================"
#echo -e "${CYAN}Listing directories... ${NC}\n"
#ls -la 
#echo -e "You can go to the below directory: \n${GREEN}$MAIN ${NC}\n"
#cd $MAIN
#echo "========================================"

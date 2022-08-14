#!/data/data/com.termux/files/usr/bin/bash
export GOPATH=/data/data/com.termux/files/home/go/
# Script for updating existing installation.
# Your ULAPPH system should be previously setup in order to run this script.
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
echo -e "###############################################"
echo -e "${Cyan}Welcome to ULAPPH-Cloud-Desktop Upgrade Tool...${NC}"
echo -e "###############################################"
#source ./setalias_ulapph.sh
TERMUX_HOME=/data/data/com.termux/files/home
ULAPPH_HOME=/data/data/com.termux/files/home/go/src/github.com/edwindvinas
SLEEP_TIME=5
#---------------------------------------------------------------------------
echo -e "${Purple}###############################################${NC}"
echo -e "${Cyan}Checking Fingerprint Authentication...${NC}"
echo -e "${Cyan}Fingerprint is needed to upgrade this system...${NC}"
echo -e "${Purple}###############################################${NC}"
FP_AUTH=`termux-fingerprint | jq .auth_result`
    echo $FP_AUTH
    if [ "$FP_AUTH" == "\"AUTH_RESULT_SUCCESS\"" ]; 
    then
        #Auth was successful
        echo -e "${Green}Good, Fingerprint Authentication...ok${NC}"
    else
        echo -e "${Red}Aborted, Fingerprint Authentication...failed!${NC}"
        exit 0
    fi

sleep $SLEEP_TIME
echo -e "************************************************"
echo -e "${Cyan}Downloading latest ULAPPH Cloud Desktop - Quick Install codes...${NC}"
echo -e "************************************************"
REP_NAME=ULAPPH-Cloud-Desktop-Quick-Install
GIT_URL=https://github.com/edwindvinas/$REP_NAME.git
echo "Removing existing folder..."
cd ${ULAPPH_HOME}
rm -rf $REP_NAME 
echo "cloning repo... "
echo $GIT_URl
git clone $GIT_URL

DIFF_UPDATE=`diff ${ULAPPH_HOME}/ULAPPH-Cloud-Desktop-Quick-Install/scripts-termux/shortcuts/ulapph/update_ulapph.sh ~/.shortcuts/ulapph/update_ulapph.sh`
if [[ "${DIFF_UPDATE}" == "" ]] ;
then
    echo -e "${Green}Good... Your old update script and the latest update script are the same...${NC}"
else
    echo -e "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo -e "${Yellow}Looks like update script is outdated... Your old update script and the latest update script are NOT the same...${NC}"
    cp ${ULAPPH_HOME}/ULAPPH-Cloud-Desktop-Quick-Install/scripts-termux/shortcuts/ulapph/update_ulapph.sh ~/.shortcuts/ulapph/update_ulapph.sh
    echo -e "${Yellow}I have copied the latest. Kindly re-run this update script...${NC}"
    echo -e "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    exit 0

fi

sleep $SLEEP_TIME
echo -e "************************************************"
echo -e "${Cyan}Backing up SSL certs inside ULAPPH Cloud Desktop folder...${NC}"
echo -e "************************************************"
cd ${ULAPPH_HOME}
mkdir -p ${ULAPPH_HOME}/.certs-ULAPPH-Cloud-Desktop
cp ${ULAPPH_HOME}/ULAPPH-Cloud-Desktop/*.crt ${ULAPPH_HOME}/.certs-ULAPPH-Cloud-Desktop/
cp ${ULAPPH_HOME}/ULAPPH-Cloud-Desktop/*.csr ${ULAPPH_HOME}/.certs-ULAPPH-Cloud-Desktop/
cp ${ULAPPH_HOME}/ULAPPH-Cloud-Desktop/*.key ${ULAPPH_HOME}/.certs-ULAPPH-Cloud-Desktop/
ls -la ${ULAPPH_HOME}/.certs-ULAPPH-Cloud-Desktop/

sleep $SLEEP_TIME
echo -e "************************************************"
echo -e "${Cyan}Downloading latest ULAPPH Cloud Desktop codes...${NC}"
echo -e "************************************************"
REP_NAME=ULAPPH-Android-Desktop
GIT_URL=https://github.com/edwindvinas/$REP_NAME.git
echo "Removing existing folder..."
cd ${ULAPPH_HOME}
rm -rf $REP_NAME 
echo "cloning repo... "
echo $GIT_URl
git clone $GIT_URL
echo "Since it is ULAPPH-Android-Desktop repo, we need to rename it to  ULAPPH Cloud Desktop..."
cd ${ULAPPH_HOME}
rm -rf ULAPPH-Cloud-Desktop 
mv ULAPPH-Android-Desktop ULAPPH-Cloud-Desktop
CERT_FILE=${ULAPPH_HOME}/.certs-ULAPPH-Cloud-Desktop/server.crt
if test -f "$CERT_FILE"; then
    echo -e "${Green}Good, certs already exists. No need to regenerate...${NC}"
else
    echo -e "${Yellow}Generating SSL certs... Just press Enter when prompted...${NC}"
    cd ULAPPH-Cloud-Desktop && ./gen_ssl_certs.sh
    echo -e "${Yellow}Done - Generated SSL certs...${NC}"
fi

sleep $SLEEP_TIME
echo -e "************************************************"
echo -e "${Cyan}Downloading latest ULAPPH Cloud Desktop - AI codes...${NC}"
echo -e "************************************************"
REP_NAME=ULAPPH-Cloud-Desktop-AI
GIT_URL=https://github.com/edwindvinas/$REP_NAME.git
echo "Removing existing folder..."
cd ${ULAPPH_HOME}
rm -rf $REP_NAME 
echo "cloning repo... "
echo $GIT_URl
git clone $GIT_URL

sleep $SLEEP_TIME
echo -e "************************************************"
echo -e "${Cyan}Downloading latest ULAPPH Cloud Desktop - Watson codes...${NC}"
echo -e "************************************************"
REP_NAME=ULAPPH-Cloud-Desktop-Watson
GIT_URL=https://github.com/edwindvinas/$REP_NAME.git
echo "Removing existing folder..."
cd ${ULAPPH_HOME}
rm -rf $REP_NAME 
echo "cloning repo... "
echo $GIT_URl
git clone $GIT_URL

sleep $SLEEP_TIME
echo -e "************************************************"
echo -e "${Cyan}Comparing your configs with the latest ULAPPH Cloud Desktop - Configs...${NC}"
echo -e "************************************************"
mkdir -p ${ULAPPH_HOME}/temp/
cd ${ULAPPH_HOME}/temp/
rm -rf ULAPPH-Cloud-Desktop-Configs/
cd ${ULAPPH_HOME}/temp/
git clone https://source.developers.google.com/p/edwin-daen-vinas/r/ULAPPH-Cloud-Desktop-Configs
NEW_CONFIGS_TOTAL=`~/go/bin/configChecker total ${ULAPPH_HOME}/temp/ULAPPH-Cloud-Desktop-Configs/ulapph-demo-android.yaml`
echo -e "NEW_CONFIGS_TOTAL: " $NEW_CONFIGS_TOTAL
OLD_CONFIGS_TOTAL=`~/go/bin/configChecker total ${ULAPPH_HOME}/ULAPPH-Cloud-Desktop-Configs/ulapph-demo-android.yaml`
echo -e "OLD_CONFIGS_TOTAL: " $OLD_CONFIGS_TOTAL

if [[ "${NEW_CONFIGS_TOTAL}" -eq "${OLD_CONFIGS_TOTAL}" ]] ;
then
    echo -e "${Green}Good... Your old config and the latest config have matching number of items...${NC}"
else
    echo -e "${Red}Not Good... Your old config and the latest config have different number of items...${NC}"
    echo -e "NOTE: Updating the configs file is being done manually... Please ask support..."
    echo -e "${Red}ANALYSIS OF MISSING CONFIGS...${NC}"
    echo -e "###############################################"
    #----
    NEW_CONFIGS_LIST=`~/go/bin/configChecker list ${ULAPPH_HOME}/temp/ULAPPH-Cloud-Desktop-Configs/ulapph-demo-android.yaml > new-cfg.txt`
    #echo -e "NEW_CONFIGS_LIST: " $NEW_CONFIGS_LIST
    OLD_CONFIGS_LIST=`~/go/bin/configChecker list ${ULAPPH_HOME}/ULAPPH-Cloud-Desktop-Configs/ulapph-demo-android.yaml > old-cfg.txt`
    #echo -e "OLD_CONFIGS_LIST: " $OLD_CONFIGS_LIST
    THIS_DIFF=`diff new-cfg.txt old-cfg.txt`
    echo -e "${Purple}$THIS_DIFF${NC}"
    echo -e "###############################################"
    echo -e "${Red}Aborted due to config issue. Please fix the issue first.${NC}"
    echo -e "${Red}Usually, you need to copy the missing items from latest to your old config.${NC}"
    exit 0
fi

sleep $SLEEP_TIME
echo -e "************************************************"
echo -e "${Cyan}Checking SSL Certificates...${NC}"
echo -e "************************************************"
cd ${ULAPPH_HOME}/ULAPPH-Cloud-Desktop
CERTS=`ls -la server.crt`
echo $CERTS
if [[ "${CERTS}" == "" ]] ;
then
    echo -e "${Red}Aborted due to SSL certs issue. Please fix the issue first.${NC}"
    echo -e "${Red}Usually, you need to generate the SSL certs.${NC}"
    echo -e "${Red}You can use below command to generate:${NC}"
    #echo -e "${Red}cd ULAPPH-Cloud-Desktop && ./gen_ssl_certs.sh ${NC}"
    echo -e "${Red}$ dev ${NC}"
    echo -e "${Red}$ ./gen_ssl_certs.sh ${NC}"
    exit 0

fi

sleep $SLEEP_TIME
echo -e "************************************************"
echo -e "${Cyan}Copying updated boot, widget and custom scripts...${NC}"
echo -e "************************************************"
cd ${TERMUX_HOME}/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-Quick-Install && ./termux_scripts_sync_local.sh

sleep $SLEEP_TIME
echo -e "************************************************"
echo -e "${Cyan}Running build & deploy script...${NC}"
echo -e "************************************************"
echo -e "NOTE: Please check the output of the build script."
cd ${TERMUX_HOME}/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-Quick-Install && ./*ANDROID*

sleep $SLEEP_TIME
echo -e "************************************************"
echo -e "${Cyan}Making sure ULAPPH is running...${NC}"
echo -e "************************************************"
ps -ax | grep main
ps -ax | grep ULAPPH 
cd /data/data/com.termux/files/home/.shortcuts/ulapph/ && ./stop_ulapph.sh
cd /data/data/com.termux/files/home/.shortcuts/ulapph/ && ./run_ulapph.sh

sleep 60

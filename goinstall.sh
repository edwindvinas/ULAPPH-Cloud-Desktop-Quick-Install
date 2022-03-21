#!/bin/bash
# shellcheck disable=SC2016
RED='\033[0;31m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e ${CYAN}"============================================="
echo -e ${YELLOW}"Welcome to ULAPPH Cloud Desktop!"
echo -e ${CYAN}"*** First-time setup script ***"
echo -e ${CYAN}"*** It will install docker first if not installed..."
echo -e ${CYAN}"*** then it will install ULAPPH in Docker... ***"
echo -e ${CYAN}"============================================="

echo -e ${RED} "Creating ulapph-temp folder..."
cd $HOME && rm -rf ulapph-temp && mkdir ulapph-temp
cd ulapph-temp
git clone https://github.com/edwindvinas/ULAPPH-Cloud-Desktop-Quick-Install.git
cd ULAPPH-Cloud-Desktop-Quick-Install
if [ -x "$(command -v docker)" ]; then
    	echo -e ${GREEN} "Found docker, will not install docker..."
    	# command
else
    	echo -e ${RED} "Docker Not Found, will install docker..."
    	# command
	chmod +x docker-install.sh
	./docker-install.sh
    	echo -e ${GREEN} "Done, docker install..."
fi
chmod +x first-time-setup.sh
./first-time-setup.sh



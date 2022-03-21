#!/bin/bash
# shellcheck disable=SC2016
RED='\033[0;31m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e ${CYAN}"============================================="
echo -e ${CYAN}"Welcome to ULAPPH Cloud Desktop!"
echo -e ${CYAN}"*** First-time setup script ***"
echo -e ${CYAN}"*** It will install Go & then ULAPPH... ***"
echo -e ${CYAN}"============================================="

cd $HOME && rm -rf ulapph-temp && mkdir ulapph-temp
cd ulapph-temp
git clone https://github.com/edwindvinas/ULAPPH-Cloud-Desktop-Quick-Install.git
cd ULAPPH-Cloud-Desktop-Quick-Install
chmod +x docker-install.sh
./docker-install.sh
chmod +x first-time-setup.sh
./first-time-setup.sh



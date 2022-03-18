#!/bin/bash
#HOME=/c/Users/edwin.d.vinas/go/src/github.com/edwindvinas
HOME=$(cd .. && pwd)

echo "#-------------quick-install-ulapph-------"
cd $HOME/quick-install-ulapph && git pull

echo "#-------------ULAPPH-Cloud-Desktop-Watson-------"
cd $HOME/ULAPPH-Cloud-Desktop-Watson && git pull

echo "#-------------ULAPPH-Cloud-Desktop-------"
cd $HOME/ULAPPH-Cloud-Desktop && git pull

echo "#-------------ULAPPH-Cloud-Desktop-AI-------"
cd $HOME/ULAPPH-Cloud-Desktop-AI && git pull

echo "#-------------ULAPPH-Cloud-Desktop-Configs-------"
cd $HOME/ULAPPH-Cloud-Desktop-Configs && git pull

echo "#-------------ULAPPH-Cloud-Desktop-CTL-------"
cd $HOME/ULAPPH-Cloud-Desktop-CTL && git pull

echo "Done"
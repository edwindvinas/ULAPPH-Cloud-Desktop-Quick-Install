#!/bin/bash
GOPATH=${GOPATH}
#git config --global user.name "edwin.d.vinas"
#git config --global user.email "edwin.d.vinas@gmail.com"

HOME=$GOPATH/src/github.com/edwindvinas
RELEASE_DATE=$(date '+%Y%m%d%H%M%S')
echo "Release Date: " $RELEASE_DATE
##-------------quick-install-ulapph-------
echo "#-------------quick-install-ulapph-------"
echo "(dep)"
echo "./commitGit.sh $RELEASE_DATE"
echo "#########################################"
#echo "Pushing quick-install-ulapph..."
#echo "Committing to repo..."
#cd $HOME/quick-install-ulapph && ./commitGit.sh $RELEASE_DATE
cd $HOME/quick-install-ulapph && git status
#
##-------------ULAPPH-Cloud-Desktop-Watson-------
echo "#-------------ULAPPH-Cloud-Desktop-Watson-------"
echo "(ws)"
echo "./commitGit.sh $RELEASE_DATE"
echo "#########################################"
#echo "Pushing ULAPPH-Cloud-Desktop-Watson..."
#echo "Committing to repo..."
#cd $HOME/ULAPPH-Cloud-Desktop-Watson && ./commitGit.sh $RELEASE_DATE
cd $HOME/ULAPPH-Cloud-Desktop-Watson && git status
#
##-------------ULAPPH-Cloud-Desktop-------
echo "#-------------ULAPPH-Cloud-Desktop-------"
echo "(dev)"
echo "./commitGit.sh $RELEASE_DATE"
echo "#########################################"
#echo "Pushing ULAPPH-Cloud-Desktop..."
#echo "Committing to repo..."
#cd $HOME/ULAPPH-Cloud-Desktop && ./commitGit.sh $RELEASE_DATE
cd $HOME/ULAPPH-Cloud-Desktop && git status
#
##-------------ULAPPH-Cloud-Desktop-AI-------
echo "#-------------ULAPPH-Cloud-Desktop-AI-------"
echo "(ai)"
echo "./commitGit.sh $RELEASE_DATE"
echo "#########################################"
#echo "Pushing ULAPPH-Cloud-Desktop-AI..."
#echo "Committing to repo..."
#cd $HOME/ULAPPH-Cloud-Desktop-AI && ./commitGit.sh $RELEASE_DATE
cd $HOME/ULAPPH-Cloud-Desktop-AI && git status
#
##-------------ULAPPH-Cloud-Desktop-Configs-------
echo "#-------------ULAPPH-Cloud-Desktop-Configs-------"
echo "(cfg)"
echo "./commitGit.sh $RELEASE_DATE"
echo "#########################################"
#echo "Pushing ULAPPH-Cloud-Desktop-Configs..."
#echo "Committing to repo..."
#cd $HOME/ULAPPH-Cloud-Desktop-Configs && ./commitGit.sh $RELEASE_DATE
cd $HOME/ULAPPH-Cloud-Desktop-Configs && git status
#
##-------------ULAPPH-Cloud-Desktop-CTL-------
echo "#-------------ULAPPH-Cloud-Desktop-CTL-------"
echo "(ctl)"
echo "./commitGit.sh $RELEASE_DATE"
echo "#########################################"
#echo "Pushing ULAPPH-Cloud-Desktop-CTL..."
#echo "Committing to repo..."
#cd $HOME/ULAPPH-Cloud-Desktop-CTL && ./commitGit.sh $RELEASE_DATE
cd $HOME/ULAPPH-Cloud-Desktop-CTL && git status
#
#echo "Done releasing updates to repo!"

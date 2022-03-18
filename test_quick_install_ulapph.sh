#!/bin/bash
#A test install script for testing certain installs
#A script for installing or upgrading multiple ULAPPH sites in one script
#For each target project ID, execute configure and install

#!!!! EDIT THIS !!!!
#Home Directory where this script is located
#Under this directory, we should find the following folders
# quick-install-ulapph - the quick installer
# ULAPPH-Cloud-Desktop-Configs/ - contains configurations for each project
# ULAPPH-Cloud-Desktop-1/ - contains the source codes of ULAPPH Cloud Desktop
HOME=/home/edwin_d_vinas/ulapph

#!!!! EDIT THIS !!!!
#Admin Email
EMAIL=edwin.d.vinas@gmail.com

#!!!! EDIT (optional) !!!!
#Verbosity {error, info, warning, debug}
VERBOSITY=debug

#!!!! EDIT THIS !!!!
#List ulapph to be deployed or installed
array=(
"edwin-daen-vinas" \
)

#!!!!! STOP EDITS HERE !!!!!!!
echo 'Installing all ulapph sites...'
echo "Number of sites: ${#array[*]}"
for ix in ${!array[*]}
do
    	printf "Installing [$ix/${#array[*]}]...  %s\n" "${array[$ix]}"
	echo '======================================'

	#Install Project
	#----------------
	PROJECT_ID=${array[$ix]}
	echo "Backing up main.go"
	cd $HOME/ULAPPH-Cloud-Desktop-1/
	cp main.go main.go.backup
	cp main.go main.go.dev

	echo "Configuring project: " $PROJECT_ID
	cd $HOME/ULAPPH-Cloud-Desktop-Configs/
	ulapphctl --config $PROJECT_ID.yaml configure

	echo "Preparing project: " $PROJECT_ID
	cd $HOME/ULAPPH-Cloud-Desktop-1/
	mv main2.go main.go

	echo "Installing via gcloud: " $PROJECT_ID
	gcloud --project=$PROJECT_ID --account=$EMAIL --verbosity=$VERBOSITY --quiet app deploy app.yaml
	echo "Cleaning up project: " $PROJECT_ID
	ulapphctl devstart
	echo '======================================'

done
echo



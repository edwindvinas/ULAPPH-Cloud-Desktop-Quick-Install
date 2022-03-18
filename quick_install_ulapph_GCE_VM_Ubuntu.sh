#!/bin/bash
#A script for installing or upgrading multiple ULAPPH sites in one script
#For each target project ID, execute configure and install

#!!!! EDIT THIS !!!!
INSTYPE=gcp-gce-ubuntu-linux 

#!!!! EDIT THIS !!!!
#Home Directory where this script is located
#Under this directory, we should find the following folders
# quick-install-ulapph - the quick installer
# ULAPPH-Cloud-Desktop-Configs/ - contains configurations for each project
# ULAPPH-Cloud-Desktop/ - contains the source codes of ULAPPH Cloud Desktop
# HOME folder
HOME=~/go/src/github.com/edwindvinas

#!!!! EDIT THIS !!!!
#Google Account 
#This account is the one with Google Cloud subscription enabled
#It should also be the owner or deployer for the project IDs
EMAIL=ulapph@gmail.com

#!!!! EDIT (optional) !!!!
#Verbosity {error, info, warning, debug}
VERBOSITY=debug

#!!!! EDIT (optional) !!!!
#Version
VERSION=afritada


#!!!! EDIT THIS !!!!
#List ulapph to be deployed or installed
#Should refer to the YAML filename w/o .yaml
array=(
"ulapph-gcp-gce-ubuntu" \
)

#!!!!! STOP EDITS HERE !!!!!!!
echo "Welcome to ULAPPH Cloud Desktop - Quick Installation Tool"

echo 'Installing ulapph cloud desktop...'
echo "Number of targets: ${#array[*]}"
for ix in ${!array[*]}
do
    	printf "Installing [$ix/${#array[*]}]...  %s\n" "${array[$ix]}"
	echo '======================================'

	#Install Project
	#----------------
	PROJECT_ID=${array[$ix]}
	echo "Backing up main.go"
	cd $HOME/ULAPPH-Cloud-Desktop/
	cp main.go main.go.backup
	cp main.go main.go.dev
	
	case "$INSTYPE" in
	"gcp-gce-ubuntu-linux") 	
				echo "*** Installation Type is ${INSTYPE} ***"
				echo "Configuring project: " $PROJECT_ID
				cd $HOME/ULAPPH-Cloud-Desktop-Configs/
				echo "Configuration used: " $PROJECT_ID
				ls $HOME/ULAPPH-Cloud-Desktop-Configs/$PROJECT_ID.yaml
				echo "Please wait... this may take a while..."
				$HOME/ULAPPH-Cloud-Desktop-CTL/ulapphctl --config $PROJECT_ID.yaml configure

				echo "Preparing project: " $PROJECT_ID
				cd $HOME/ULAPPH-Cloud-Desktop/
				mv main2.go main.go
				echo "Executing go build main.go"
				go build main.go
				echo "Cleaning up project: " $PROJECT_ID
				$HOME/ULAPPH-Cloud-Desktop-CTL/ulapphctl devstart 
				echo "Running executable main as ULAPPH local server..."
				./main 
	;;
	*) 			echo "*** ERROR: Installation Type is NOT SUPPORTED ***"
				exit 1
	;;
	esac

	echo '======================================'
done
echo '============='

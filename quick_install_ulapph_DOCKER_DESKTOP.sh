#!/bin/bash
#A script for installing or upgrading multiple ULAPPH sites in one script
#For each target project ID, execute configure and install

#!!!! EDIT THIS !!!!
#Installation type (local, gae)
#local-windows - Windows laptop, desktop
#local-linux - Windows laptop, desktop
#gae - google appengine
#gcr - google cloud run
#gke - gogole kubernetes engine
#android  - app for Android
#INSTYPE=local-windows 
#INSTYPE=gae
#INSTYPE=gcr 
INSTYPE=docker-desktop # same as docker-hub except that it doesn't upload to docker hub
#INSTYPE=android
#INSTYPE=gke

#!!!! EDIT THIS !!!!
#Home Directory where this script is located
#Under this directory, we should find the following folders
# quick-install-ulapph - the quick installer
# ULAPPH-Cloud-Desktop-Configs/ - contains configurations for each project
# ULAPPH-Cloud-Desktop/ - contains the source codes of ULAPPH Cloud Desktop
# Sample HOME for Windows with Gitbash
HOME=~/go/src/github.com/edwindvinas
# Sample HOME for Google Cloud Shell
#HOME=/home/ulapph/gopath/src/github.com/edwindvinas

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
array=(
#"edwin-daen-vinas" \
#"ulapph" \
#"ulapph-demo-local" \
#"ulapph-demo-gcr" \
"ulapph-demo-docker-desktop" \
#"ulapph-demo" \
#"ulapph-portal" \
)

#!!!!! STOP EDITS HERE !!!!!!!
echo "Welcome to ULAPPH Cloud Desktop - Quick Installation Tool"
#echo "First, lets execute \"go vet main.go\""
#cd $HOME/ULAPPH-Cloud-Desktop/
#result=$(go vet main.go)
#if [[ $? != 0 ]]; then
#    echo "*********** $? ***************"
#elif [[ $result ]]; then
#    echo "*********** Compile error: Please fix the code issues first. ***************"
#	exit 1
#else
#	echo "Success: go vet executed: No errors found"
#fi
#echo "Great, code does not have syntax errors..."
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
	"docker-desktop")
				echo "*** Installation Type is DOCKER DESKTOP ***" 
				echo "Configuring project: " $PROJECT_ID
				cd $HOME/ULAPPH-Cloud-Desktop-Configs/
				echo "Configuration used: " $PROJECT_ID
				ls $HOME/ULAPPH-Cloud-Desktop-Configs/$PROJECT_ID.yaml
				echo "Please wait... this may take a while..."
				go run $HOME/ULAPPH-Cloud-Desktop-CTL/ulapphctl.go --config $PROJECT_ID.yaml configure

				echo "Preparing project: " $PROJECT_ID
				cd $HOME/ULAPPH-Cloud-Desktop/
				mv main2.go main.go

				echo "Copying the AI folder..."
				mkdir $HOME/ULAPPH-Cloud-Desktop/ai
				cp -R $HOME/ULAPPH-Cloud-Desktop-AI/* $HOME/ULAPPH-Cloud-Desktop/ai/

				echo "Stopping local ulapph instance..."
				cd $HOME/quick-install-ulapph/
				./stop_local_ulapph.sh

				echo "Exporting watson..."
				cd $HOME/ULAPPH-Cloud-Desktop-Watson/
				$HOME/ULAPPH-Cloud-Desktop-Watson/ta_export_watson_DOCKER_DESKTOP.sh
				echo 'Creating AI Menu...'
				echo 'Saving file: $HOME/ULAPPH-Cloud-Desktop/templates/ulapph-ai-menu.txt'
				go run $HOME/ULAPPH-Cloud-Desktop-Watson/genUlapphAiMenu.go --output $HOME/ULAPPH-Cloud-Desktop/templates/ulapph-ai-menu.txt --inputs "$HOME/ULAPPH-Cloud-Desktop-Watson/00 - Intent Router.json" "$HOME/ULAPPH-Cloud-Desktop-Watson/10 - GoogleCloudPlatformAssistant.json" "$HOME/ULAPPH-Cloud-Desktop-Watson/99 - General.json"

				echo "Performing dos2unix..."
				cd $HOME/ULAPPH-Cloud-Desktop/
				/usr/bin/dos2unix gogetall.sh
				echo "Building image..."
				docker build -t ulapph-cloud-desktop .
					
				#echo "Tagging image..."
				#sudo docker tag ulapph-cloud-desktop:latest edwindvinas/ulapph-cloud-desktop:latest

				#echo "Pushing image..."
				#sudo docker push edwindvinas/ulapph-cloud-desktop:latest

				echo "Removing temp AI folder..."
				rm -rf $HOME/ULAPPH-Cloud-Desktop/ai

				echo "Cleaning up project: " $PROJECT_ID
				go run $HOME/ULAPPH-Cloud-Desktop-CTL/ulapphctl.go devstart

				echo "Stopping existing service in Docker Desktop..."
				echo "docker stop ulapph-cloud-desktop"
				docker stop ulapph-cloud-desktop
				docker rm ulapph-cloud-desktop
				
				echo "You can now run in Docker Desktop..."
				echo "docker run -d -p 8443:8443 --name ulapph-cloud-desktop ulapph-cloud-desktop"
				docker run -d -p 8443:8443 --name ulapph-cloud-desktop ulapph-cloud-desktop
				echo "Done. Please check docker desktop dashboard."
	;;
	*) 			echo "*** ERROR: Installation Type is NOT SUPPORTED ***"
				exit 1
	;;
	esac

	echo '======================================'
done
echo '============='

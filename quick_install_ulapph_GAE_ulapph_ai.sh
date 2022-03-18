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
INSTYPE=gae
#INSTYPE=gcr 
#INSTYPE=android
#INSTYPE=gke

#!!!! EDIT THIS !!!!
#Home Directory where this script is located
#Under this directory, we should find the following folders
# quick-install-ulapph - the quick installer
# ULAPPH-Cloud-Desktop-Configs/ - contains configurations for each project
# ULAPPH-Cloud-Desktop/ - contains the source codes of ULAPPH Cloud Desktop
# Sample HOME for Windows with Gitbash
HOME=/c/Users/edwin.d.vinas/go/src/github.com/edwindvinas
# Sample HOME for Google Cloud Shell
#HOME=/home/ulapph/gopath/src/github.com/edwindvinas

#!!!! EDIT THIS !!!!
#Google Account 
#This account is the one with Google Cloud subscription enabled
#It should also be the owner or deployer for the project IDs
EMAIL=edwin.d.vinas@gmail.com

#!!!! EDIT (optional) !!!!
#Verbosity {error, info, warning, debug}
VERBOSITY=debug

#!!!! EDIT (optional) !!!!
#Version
VERSION=afritada

#!!!! EDIT (optional) !!!!
#Watson Export
WATSON_EXPORT=Y

#!!!! EDIT THIS !!!!
#List ulapph to be deployed or installed
array=(
#"edwin-daen-vinas" \
#"ulapph" \
#"ulapph-demo-local" \
#"ulapph-demo-cr" \
#"ulapph-demo" \
"ulapph-ai" \
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
	"gae") 		
		echo "*** Installation Type is GOOGLE APPENGINE STANDARD ***" 
		echo "Configuring project: " $PROJECT_ID
		cd $HOME/ULAPPH-Cloud-Desktop-Configs/
		echo "Configuration used: " $PROJECT_ID
		ls $HOME/ULAPPH-Cloud-Desktop-Configs/$PROJECT_ID.yaml
		echo "Please wait... this may take a while..."
		go run $HOME/ULAPPH-Cloud-Desktop-CTL/ulapphctl.go --config $PROJECT_ID.yaml configure
		#/c/Users/edwin.d.vinas/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-CTL/ulapphctl --config ulapph-portal.yaml configure
		echo "Preparing project: " $PROJECT_ID
		cd $HOME/ULAPPH-Cloud-Desktop/
		mv main2.go main.go
		#cp main.go main.go.deployed
		if [ $WATSON_EXPORT == "Y" ]
		then
			echo "Watson Export Flag = Y ..."
			echo "Exporting watson..."
			cd $HOME/ULAPPH-Cloud-Desktop-Watson/
			$HOME/ULAPPH-Cloud-Desktop-Watson/ta_export_watson.sh
			echo 'Creating AI Menu...'
			echo 'Saving file: $HOME/ULAPPH-Cloud-Desktop/templates/ulapph-ai-menu.txt'
			#/c/Go/bin/go run $HOME/ULAPPH-Cloud-Desktop-Watson/genUlapphAiMenu.go --output $HOME/ULAPPH-Cloud-Desktop/templates/ulapph-ai-menu.txt --inputs "$HOME/ULAPPH-Cloud-Desktop-Watson/99 - General.json"
			/c/Go/bin/go run $HOME/ULAPPH-Cloud-Desktop-Watson/genUlapphAiMenu.go --output $HOME/ULAPPH-Cloud-Desktop/templates/ulapph-ai-menu.txt --inputs "$HOME/ULAPPH-Cloud-Desktop-Watson/00 - Intent Router.json" "$HOME/ULAPPH-Cloud-Desktop-Watson/10 - GoogleCloudPlatformAssistant.json" "$HOME/ULAPPH-Cloud-Desktop-Watson/20 - TechnologyArchitect.json" "$HOME/ULAPPH-Cloud-Desktop-Watson/30 - EnterpriseArchitect.json" "$HOME/ULAPPH-Cloud-Desktop-Watson/99 - General.json"
		else
			echo "Watson Export Flag = N ..."
			echo "Skipping Watson Export..."
		fi
		echo "Stopping local ulapph instance..."
		cd $HOME/quick-install-ulapph/
		./stop_local_ulapph.sh
		cd $HOME/ULAPPH-Cloud-Desktop/
		echo "Installing cron via gcloud: " $PROJECT_ID
		gcloud --project=$PROJECT_ID --account=$EMAIL --verbosity=$VERBOSITY --quiet app deploy cron.yaml
		echo "Installing app via gcloud: " $PROJECT_ID
		gcloud --project=$PROJECT_ID --account=$EMAIL --verbosity=$VERBOSITY --quiet app deploy app.yaml
		echo "Cleaning up project: " $PROJECT_ID
		go run $HOME/ULAPPH-Cloud-Desktop-CTL/ulapphctl.go devstart 
	;;
	*) 
		echo "*** ERROR: Installation Type is NOT SUPPORTED ***"
		exit 1
	;;
	esac
	echo '======================================'
done
echo '============='
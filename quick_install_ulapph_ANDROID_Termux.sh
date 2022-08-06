#!/data/data/com.termux/files/usr/bin/bash
#A script for installing or upgrading multiple ULAPPH sites in one script
#For each target project ID, execute configure and install
#-------------------------------------
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
#-------------------------------------

GOPATH=/data/data/com.termux/files/home/go
export GO111MODULE=off

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
INSTYPE=android
#INSTYPE=gke

#!!!! EDIT THIS !!!!
#Home Directory where this script is located
#Under this directory, we should find the following folders
# quick-install-ulapph - the quick installer
# ULAPPH-Cloud-Desktop-Configs/ - contains configurations for each project
# ULAPPH-Cloud-Desktop/ - contains the source codes of ULAPPH Cloud Desktop
# Sample HOME for Windows with Gitbash
#HOME=/c/Users/edwin.d.vinas/go/src/github.com/edwindvinas
HOME=/data/data/com.termux/files/home/go/src/github.com/edwindvinas
#DATA_HOME=/data/data/com.termux/files/home/storage/ulapph/
#DATA_HOME=/data/data/com.termux/files/home/storage/external-1/ulapph
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
VERSION=bopis

WATSON_EXPORT=N

#!!!! EDIT THIS !!!!
#List ulapph to be deployed or installed
array=(
#"edwin-daen-vinas" \
#"ulapph" \
#"ulapph-demo-local" \
"ulapph-demo-android" \
#"ulapph-demo-cr" \
#"ulapph-demo" \
#"ulapph-portal" \
)

#!!!!! STOP EDITS HERE !!!!!!!
echo -e "${Cyan}Welcome to ULAPPH Cloud Desktop - Quick Installation Tool${NC}"
#echo -e "First, lets execute \"go vet main.go\""
#cd $HOME/ULAPPH-Cloud-Desktop/
#result=$(go vet main.go)
#if [[ $? != 0 ]]; then
#    echo -e "*********** $? ***************"
#elif [[ $result ]]; then
#    echo -e "*********** Compile error: Please fix the code issues first. ***************"
#	exit 1
#else
#	echo -e "Success: go vet executed: No errors found"
#fi
#echo -e "Great, code does not have syntax errors..."
echo -e 'Installing ulapph cloud desktop...'
echo -e "Number of targets: ${#array[*]}"
for ix in ${!array[*]}
do
    	printf "Installing [$ix/${#array[*]}]...  %s\n" "${array[$ix]}"
	echo -e '======================================'

	#Install Project
	#----------------
	PROJECT_ID=${array[$ix]}
	echo -e "Backing up main.go"
	cd $HOME/ULAPPH-Cloud-Desktop/
	cp main.go main.go.backup
	cp main.go main.go.dev
	
	case "$INSTYPE" in
	"android") 	
				echo -e "${Red}*** Installation Type is ANDROID ***${NC}"
				if [ "$1" == "" ]
			 	then	
					echo -e "${Cyan}Configuring project: " $PROJECT_ID ${NC}
					cd $HOME/ULAPPH-Cloud-Desktop-Configs/
					echo -e "${Cyan}Configuration used: " $PROJECT_ID ${NC}
					ls $HOME/ULAPPH-Cloud-Desktop-Configs/$PROJECT_ID.yaml
					echo -e "${Yellow}Please wait... this may take a while...${NC}"
					#go run $HOME/ULAPPH-Cloud-Desktop-CTL/ulapphctl.go --config $PROJECT_ID.yaml configure
                    echo -e "${Green}"
					$GOPATH/bin/ulapphctl --config $PROJECT_ID.yaml configure
                    echo -e "${NC}"

					echo -e "${Cyan}Preparing project: " $PROJECT_ID ${NC}
					cd $HOME/ULAPPH-Cloud-Desktop/
					mv main2.go main.go
					#cp main.go main.go.deployed
					#Remove current wallpapers
					rm $HOME/ULAPPH-Cloud-Desktop/static/img/wallpapers/*
					#Overwrite wallpapers
					cp $HOME/ULAPPH-Cloud-Desktop-WP/termux/* $HOME/ULAPPH-Cloud-Desktop/static/img/wallpapers/
					#Share android folder
					#echo -e "Liking android data to android folder..."
					#cd $HOME/ULAPPH-Cloud-Desktop/android/
					#ln -s dcim /data/data/com.termux/files/home/storage/dcim/
					#-------------WATSON-------
					#Remove current ai folder
					rm -rf $HOME/ULAPPH-Cloud-Desktop/ai/*
					#Overwrite ai folder
                    mkdir -p $HOME/ULAPPH-Cloud-Desktop/ai
					cp -R $HOME/ULAPPH-Cloud-Desktop-AI/ai/* $HOME/ULAPPH-Cloud-Desktop/ai/
					if [ $WATSON_EXPORT == "Y" ]
					then
						echo -e "${Purple}Exporting watson...${NC}"
						cd $HOME/ULAPPH-Cloud-Desktop-Watson/
						$HOME/ULAPPH-Cloud-Desktop-Watson/ta_export_watson_ANDROID.sh
						echo -e 'Creating AI Menu...'
						echo -e 'Saving file: $HOME/ULAPPH-Cloud-Desktop/templates/ulapph-ai-menu.txt'
						go run $HOME/ULAPPH-Cloud-Desktop-Watson/genUlapphAiMenu.go --output $HOME/ULAPPH-Cloud-Desktop/templates/ulapph-ai-menu.txt --inputs "$HOME/ULAPPH-Cloud-Desktop-Watson/00 - Intent Router.json" "$HOME/ULAPPH-Cloud-Desktop-Watson/10 - GoogleCloudPlatformAssistant.json" "$HOME/ULAPPH-Cloud-Desktop-Watson/20 - TechnologyArchitect.json" "$HOME/ULAPPH-Cloud-Desktop-Watson/30 - EnterpriseArchitect.json" "$HOME/ULAPPH-Cloud-Desktop-Watson/99 - General.json"
					else
						echo -e "${Purple}Watson Export Flag = N ...${NC}"
						echo -e "Skipping Watson Export..."
					fi
					cd $HOME/ULAPPH-Cloud-Desktop/
					echo -e "########################################"
					echo -e "${Cyan}Executing go build main.go${NC}"
					echo -e "########################################"
                    echo -e "${Red}"
					go build main.go
					cp main.go main.go.debug
                    echo -e "${NC}"
					echo -e "########################################"
					echo -e "${Cyan}Cleaning up project: " $PROJECT_ID ${NC}
					#go run $HOME/ULAPPH-Cloud-Desktop-CTL/ulapphctl.go devstart 
					$GOPATH/bin/ulapphctl devstart 
					#echo -e "Setting up GCP service credentials..."
					#export GOOGLE_APPLICATION_CREDENTIALS=$HOME/ULAPPH-Cloud-Desktop-Configs/ulapph-demo-f37e0e225c81.json
					#-------------TIEDOT DB-------
					#echo -e "Stopping tiedot db..."
					#curl "http://localhost:6060/shutdown"
					#echo -e "Running tiedot db..."
					#$GOPATH/bin/tiedot -mode=httpd -dir=$DATA_HOME/tiedot -port=6060 &
					#echo -e "Indexing TDSMEDIA collection in tiedotDB..."
					#curl "http://localhost:6060/index?col=TDSMEDIA&path=MEDIA_ID"
					#curl "http://localhost:6060/index?col=TDSMEDIA&path=DT_UPLOAD"
					#curl "http://localhost:6060/index?col=TDSMEDIA&path=CATEGORY"
					#curl "http://localhost:6060/index?col=TDSSLIDE&path=DOC_ID"
					#curl "http://localhost:6060/index?col=TDSSLIDE&path=DT_UPLOAD"
					#curl "http://localhost:6060/index?col=TDSSLIDE&path=CATEGORY"
					#curl "http://localhost:6060/index?col=TDSARTL&path=DOC_ID"
					#curl "http://localhost:6060/index?col=TDSARTL&path=DT_UPLOAD"
					#curl "http://localhost:6060/index?col=TDSARTL&path=CATEGORY"
					#-------------SEAWEEDFS-------
					#echo -e "Stopping seaweedfs..."
					#ps aux | grep weed | grep -v "grep weed" | awk '{print $2}' | xargs kill -9
					#echo -e "Running SeaweedFS...master"
					#$GOPATH/bin/weed master &
					#echo -e "Running SeaweedFS...starting volume server 1..."
					#$GOPATH/bin/weed volume -dir=$DATA_HOME/swfs -max=10  -mserver="localhost:9333" -port=7070 &
					#-------------ULAPPH-------
					echo -e "${Cyan}Stopping ulapph...${NC}"
					ps aux | grep ULAPPH-Cloud-Desktop | grep -v "grep ULAPPH-Cloud-Desktop" | awk '{print $2}' | xargs kill -9
					ps aux | grep main | grep -v "grep main" | awk '{print $2}' | xargs kill -9
					echo -e "${Cyan}Starting ULAPPH local server...${NC}"
					./main &
				fi
	;;
	*) 			echo -e "*** ERROR: Installation Type is NOT SUPPORTED ***"
				exit 1
	;;
	esac

	echo -e '======================================'
done
echo -e '============='

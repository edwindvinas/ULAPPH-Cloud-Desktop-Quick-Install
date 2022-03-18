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
INSTYPE=local-windows 
#INSTYPE=gae
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
EMAIL=ulapph@gmail.com

#!!!! EDIT (optional) !!!!
#Verbosity {error, info, warning, debug}
VERBOSITY=debug

#!!!! EDIT (optional) !!!!
#Version
VERSION=afritada

#!!!! EDIT (optional) !!!!
#Watson Export
WATSON_EXPORT=N


#!!!! EDIT THIS !!!!
#List ulapph to be deployed or installed
array=(
#"edwin-daen-vinas" \
#"ulapph" \
"ulapph-demo-local" \
#"ulapph-demo-cr" \
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
	"local-windows") 	
				echo "*** Installation Type is LOCAL ***"
				if [ "$1" == "reload" ]
				then
					echo "Rebooting server...will not rebuild..."
					echo "Setting up GCP service credentials..."
					export GOOGLE_APPLICATION_CREDENTIALS="/c/Users/edwin.d.vinas/go/src/github.com/edwindvinas/ulapph-demo-f37e0e225c81.json"
					#echo "Stopping python emulator for DS..."
					#ps aux | grep python | grep -v "grep python" | awk '{print $2}' | xargs kill -9
					#echo "Starting Datastore emulator..."
					#gcloud beta emulators datastore start &
					#echo "Copying fresh images..."
					#cp -R $HOME/ULAPPH-Cloud-Desktop/static.bak/img $HOME/ULAPPH-Cloud-Desktop/static/
					#-------------TIEDOT DB-------
					echo "Stopping tiedot db..."
					curl "http://localhost:6060/shutdown"
					echo "Running tiedot db..."
					$GOPATH/bin/tiedot -mode=httpd -dir=/c/Development/tiedot/data -port=6060 &
					#-------------SEAWEEDFS-------
					echo "Stopping seaweedfs..."
					ps aux | grep weed | grep -v "grep weed" | awk '{print $1}' | xargs kill -9
					echo "Running SeaweedFS...master"
					/c/Development/seaweedfs/weed master &
					echo "Running SeaweedFS...starting volume server 1..."
					#/c/Development/seaweedfs/weed volume -dir="/c/Development/seaweedfs/data" -max=10  -mserver="localhost:9333" -port=7070 &
					/c/Development/seaweedfs/weed volume -dir="/c/Development/seaweedfs/data3" -max=10  -mserver="localhost:9333" -port=7070 &
					#/c/Development/seaweedfs/weed volume -dir="/c/Development/seaweedfs/data" -max=10  -mserver="192.168.1.4:9333" -port=7070 &
					#echo "Running SeaweedFS...starting volume server 2..."
					#/c/Development/seaweedfs/weed volume -dir="/c/Development/seaweedfs/data2" -max=10  -mserver="localhost:9333" -port=7071 &
					#-------------NSQ-------
					#echo "Stopping nsq..."
					#ps aux | grep nsq | grep -v "grep nsq" | awk '{print $1}' | xargs kill -9
					#echo "Running NSQ Lookup..."
					#/c/Development/nsq/nsqlookupd &
					#echo "Running NSQ Daemon..."
					#/c/Development/nsq/nsqd --lookupd-tcp-address=127.0.0.1:4160 -tls-cert=cert.pem -tls-key=key.pem -tls-required=true -tls-client-auth-policy=require &
					#/c/Development/nsq/nsqd --lookupd-tcp-address=127.0.0.1:4160 &
					#echo "Running NSQ Admin..."
					#/c/Development/nsq/nsqadmin --lookupd-http-address=127.0.0.1:4161 &
					#-------------ULAPPH-------
					# Create indexes in TDSMEDIA in MEDIA_ID column
					#curl "http://localhost:6060/all"
					#curl "http://localhost:6060/indexes?col=TDSMEDIA"
					#curl "http://localhost:6060/index?col=TDSMEDIA&path=MEDIA_ID"
					echo "Stopping ulapph..."
					ps aux | grep ULAPPH-Cloud-Desktop | grep -v "grep ULAPPH-Cloud-Desktop" | awk '{print $1}' | xargs kill -9
					echo "Starting ULAPPH local server..."
					./main &
				else
					echo "Configuring project: " $PROJECT_ID
					cd $HOME/ULAPPH-Cloud-Desktop-Configs/
					echo "Configuration used: " $PROJECT_ID
					ls $HOME/ULAPPH-Cloud-Desktop-Configs/$PROJECT_ID.yaml
					echo "Please wait... this may take a while..."
					go run $HOME/ULAPPH-Cloud-Desktop-CTL/ulapphctl.go --config $PROJECT_ID.yaml configure

					echo "Preparing project: " $PROJECT_ID
					cd $HOME/ULAPPH-Cloud-Desktop/
					mv main2.go main.go
					#cp main.go main.go.deployed
					#-------------WATSON-------
					if [ $WATSON_EXPORT == "Y" ]
					then
						echo "Watson Export Flag = Y ..."
						echo "Exporting watson..."
						cd $HOME/ULAPPH-Cloud-Desktop-Watson/
						$HOME/ULAPPH-Cloud-Desktop-Watson/ta_export_watson.sh
						echo 'Creating AI Menu...'
						echo 'Saving file: $HOME/ULAPPH-Cloud-Desktop/templates/ulapph-ai-menu.txt'
						/c/Go/bin/go run $HOME/ULAPPH-Cloud-Desktop-Watson/genUlapphAiMenu.go --output $HOME/ULAPPH-Cloud-Desktop/templates/ulapph-ai-menu.txt --inputs "$HOME/ULAPPH-Cloud-Desktop-Watson/00 - Intent Router.json" "$HOME/ULAPPH-Cloud-Desktop-Watson/10 - GoogleCloudPlatformAssistant.json" "$HOME/ULAPPH-Cloud-Desktop-Watson/20 - TechnologyArchitect.json" "$HOME/ULAPPH-Cloud-Desktop-Watson/30 - EnterpriseArchitect.json" "$HOME/ULAPPH-Cloud-Desktop-Watson/99 - General.json"
					else
						echo "Watson Export Flag = N ..."
						echo "Skipping Watson Export..."
					fi
					#-------------BUILD-------
					cd $HOME/ULAPPH-Cloud-Desktop/
					echo "Executing go build main.go"
					go build main.go
					echo "Cleaning up project: " $PROJECT_ID
					go run $HOME/ULAPPH-Cloud-Desktop-CTL/ulapphctl.go devstart
					echo "Setting up GCP service credentials..."
					export GOOGLE_APPLICATION_CREDENTIALS="/c/Users/edwin.d.vinas/go/src/github.com/edwindvinas/ulapph-demo-f37e0e225c81.json"
					#echo "Stopping python emulator for DS..."
					#ps aux | grep python | grep -v "grep python" | awk '{print $2}' | xargs kill -9
					#echo "Starting Datastore emulator..."
					#gcloud beta emulators datastore start &
					#echo "Copying fresh images..."
					#cp -R $HOME/ULAPPH-Cloud-Desktop/static.bak/img $HOME/ULAPPH-Cloud-Desktop/static/ 
					#-------------TIEDOT DB-------
					echo "Stopping tiedot db..."
					curl "http://localhost:6060/shutdown"
					echo "Running tiedot db..."
					$GOPATH/bin/tiedot -mode=httpd -dir=/c/Development/tiedot/data -port=6060 &
					#-------------SEAWEEDFS-------
					echo "Stopping seaweedfs..."
					ps aux | grep weed | grep -v "grep weed" | awk '{print $1}' | xargs kill -9
					echo "Running SeaweedFS...master"
					/c/Development/seaweedfs/weed master &
					echo "Running SeaweedFS...starting volume server 1..."
					#/c/Development/seaweedfs/weed volume -dir="/c/Development/seaweedfs/data" -max=10  -mserver="localhost:9333" -port=7070 &
					/c/Development/seaweedfs/weed volume -dir="/c/Development/seaweedfs/data3" -max=10  -mserver="localhost:9333" -port=7070 &
					#/c/Development/seaweedfs/weed volume -dir="/c/Development/seaweedfs/data" -max=10  -mserver="192.168.1.4:9333" -port=7070 &
					#echo "Running SeaweedFS...starting volume server 2..."
					#/c/Development/seaweedfs/weed volume -dir="/c/Development/seaweedfs/data2" -max=10  -mserver="localhost:9333" -port=7071 &
					#-------------NSQ-------
					#echo "Stopping nsq..."
					#ps aux | grep nsq | grep -v "grep nsq" | awk '{print $1}' | xargs kill -9
					#echo "Running NSQ Lookup..."
					#/c/Development/nsq/nsqlookupd &
					#echo "Running NSQ Daemon..."
					#/c/Development/nsq/nsqd --lookupd-tcp-address=127.0.0.1:4160 -tls-cert=cert.pem -tls-key=key.pem -tls-required=true -tls-client-auth-policy=require &
					#/c/Development/nsq/nsqd --lookupd-tcp-address=127.0.0.1:4160 &
					#echo "Running NSQ Admin..."
					#/c/Development/nsq/nsqadmin --lookupd-http-address=127.0.0.1:4161 &
					#-------------ULAPPH-------
					echo "Stopping ulapph..."
					ps aux | grep ULAPPH-Cloud-Desktop | grep -v "grep ULAPPH-Cloud-Desktop" | awk '{print $1}' | xargs kill -9
					echo "Starting ULAPPH local server..."
					./main &
				fi
	;; 
	*) 			echo "*** ERROR: Installation Type is NOT SUPPORTED ***"
				exit 1
	;;
	esac

	echo '======================================'
done
echo '============='
#!/bin/sh
GOPATH=${GOPATH}
echo "Creating GOPATH..."
mkdir ~/go
export GOPATH=~/go
mkdir $GOPATH/src/github.com/edwindvinas

echo "Install NOSQL using tiedot..."
mkdir $GOPATH/src/github.com/edwindvinas/data-nosql
go get github.com/edwindvinas/tiedot

echo "Install Blobstorage using SeaweedFS..."
mkdir $GOPATH/src/github.com/edwindvinas/data-blobstore
cd ~
wget https://github.com/chrislusf/seaweedfs/releases/download/1.77/linux_amd64.tar.gz
tar -xvf linux_amd64.tar.gz
ls weed
cp weed $GOPATH/bin/

echo "Copy setalias_ulapph script..."
cp $GOPATH/src/github.com/edwindvinas/quick-install-ulapph/setalias_ulapph_AWS_EC2.sh ~/setalias_ulapph.sh
source ~/setalias_ulapph.sh

echo "Download dependencies..."
dev
chmod +x gogetall.sh
./gogetall.sh

echo "Building ctl script..."
ctl
./gogetall.sh
go build ulapphctl.go
ls ulapphctl
cp ulapphctl $GOPATH/bin/
ls -la $GOPATH/bin/

echo "Chmod commit scripts..."
dev
chmod +x commitGit.sh
dep
chmod +x commitGit.sh
ws
chmod +x commitGit.sh
ai
chmod +x commitGit.sh
cfg
chmod +x commitGit.sh
ai
chmod +x commitGit.sh
ctl
chmod +x commitGit.sh

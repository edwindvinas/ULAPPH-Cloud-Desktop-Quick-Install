#!/bin/bash
echo "Installing ngrok...please wait..."
HOME=/data/data/com.termux/files/home/go/src/github.com/edwindvinas
DATA_HOME=/data/data/com.termux/files/home/storage
GOBIN=/data/data/com.termux/files/home/go/bin/

cd $HOME
echo "Downloading NGROK..."
INSTALLER=https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz
echo "wget " $INSTALLER
wget $INSTALLER

echo "Extracting ngrok..."
INSFILE=ngrok-v3-stable-linux-arm64.tgz
echo "tar -zxvf " $INSFILE
tar -zxvf $INSFILE

echo "Copying to Go bin folder..."
echo "mv ngrok " $GOBIN
mv ngrok $GOBIN



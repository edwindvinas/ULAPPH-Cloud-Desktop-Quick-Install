#!/data/data/com.termux/files/usr/bin/bash

TERMUX_HOME=/data/data/com.termux/files/home
export GO111MODULE=off

alias dev='cd ~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop'
alias ai='cd ~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-AI'
alias watson='cd ~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-Watson'
alias ctl='cd ~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-CTL'
alias cfg='cd ~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-Configs'
alias dep='cd ~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-Quick-Install'
alias rel='cd ~/go/src/github.com/edwindvinas/ULAPPH-Release'
alias deploy-android='cd ~/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-Quick-Install && ./*ANDROID*'
alias edit-cfg='cfg && vim ulapph-demo-android.yaml'
alias edit-main='dev && vim main.go'
alias data='cd ~/storage/ulapph/ulapph-data'
alias stop='~/stop_ulapph.sh'
alias short='cd ~/.shortcuts'
alias aic='/data/data/com.termux/files/home/go/src/github.com/edwindvinas/ULAPPH-Cloud-Desktop-AI/ai/syncToLiveFolder.sh'

export GOPATH=$PATH:~/go
export PATH=$PATH:~/go/bin

THIS_IP=`${TERMUX_HOME}/go/bin/getip`


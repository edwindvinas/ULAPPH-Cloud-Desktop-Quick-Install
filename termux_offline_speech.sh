#!/bin/bash
echo "Downloading DeepSpeech..."
pkg i -y git && git clone https://github.com/T-vK/Termux-DeepSpeech.git && cd ./Termux-DeepSpeech && ./speech2text

echo "Creating ~/.shortcuts/ directory..."
mkdir -p ~/.shortcuts
chmod 700 -R ~/.shortcuts

echo "Creating ~/.shortcuts/tasks directory..."
mkdir -p ~/.shortcuts/tasks
chmod 700 -R ~/.shortcuts/tasks

echo "Creating ~/.shortcuts/icons directory..."
mkdir -p ~/.shortcuts/icons
chmod -R a-x,u=rwX,go-rwx ~/.shortcuts/icons

# For extracting data from json
# JQ commands: 
# https://tecadmin.net/linux-jq-command/
echo "Installing pkg install jq..."
pkg install jq

# To update widget
# am broadcast -n com.termux.widget/.TermuxWidgetProvider -a com.termux.widget.ACTION_REFRESH_WIDGET --ei appWidgetId 4

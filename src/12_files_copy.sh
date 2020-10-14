#!/bin/bash

# This script prompts src from where to copy and copies
# files to /var/www/html/

source ../animation.sh

LOCAL_DIR="/var/www/html/"

/usr/bin/printf "\n${WHITE}\nNow it's time to copy html files from your REMOTE to your local system${NC}"
start_and_stop_animation dot 2

read -p "Give username of your REMOTE machine: " USERNAME
read -p "Give IP address of your REMOTE machine: " IP
read -p "SSH port number of your REMOTE machine: " PORT
read -p "Give full path to the html files on your REMOTE machine which will be copied: " REMOTE_DIR

/usr/bin/printf "\n${WHITE}\nThanks!\n\n${NC}"
/usr/bin/printf "${WHITE}Copying${NC}"
start_and_stop_animation dot 2

/usr/bin/scp -r -P "${PORT}" "${USERNAME}"@"${IP}":"${REMOTE_DIR}" "${LOCAL_DIR}"
STATUS_SYMBOLS[10]=${SUCCESS}
#!/bin/bash

# This script prompts src from where to copy and copies
# files to /var/www/html/

LOCAL_DIR="/var/www/html/"

printf "\n${WHITE}\nNow it's time to copy html files from your remote to your local system${NC}"
start_and_stop_animation dot 2

read -p "Give username of your remote machine: " USERNAME
read -p "Give IP address of your remote machine: " IP
read -p "SSH port number of your remote machine: " PORT
read -p "Give directory path to the html files on your remote machine which will be copied: " REMOTE_DIR

printf "\n${WHITE}\nThanks!\n\n${NC}"
printf "${WHITE}Copying${NC}"
start_and_stop_animation dot 2

scp -r -P "${PORT}" "${USERNAME}"@"${IP}":"${REMOTE_DIR}" "${LOCAL_DIR}"
STATUS_SYMBOLS[10]=${SUCCESS}
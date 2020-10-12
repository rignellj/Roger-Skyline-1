#!/bin/bash

# This script prompts src from where to copy and copies
# files to /var/www/html/

WHITE="\033[1;37m"
RED="\033[1;31m"
RESET="\033[0m"

LOCAL_DIR="/var/www/html/"

printf "\n${WHITE}\nNow it's time to copy html files from your remote to your local system\n\n${RESET}"
sleep 2

read -p "Give username of your remote machine: " USERNAME
read -p "Give IP address of your remote machine: " IP
read -p "SSH port number of your remote machine: " PORT
read -p "Give directory path to the html files on your remote machine which will be copied: " REMOTE_DIR

printf "\n${WHITE}\nThanks!\n\n${RESET}"
printf "${WHITE}Copying...\n\n${RESET}"
sleep 2

scp -r -P "${PORT}" "${USERNAME}"@"${IP}":"${REMOTE_DIR}" "${LOCAL_DIR}"

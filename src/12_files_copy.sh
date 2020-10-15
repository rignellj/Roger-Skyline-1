#!/bin/bash

# This script prompts src from where to copy and copies
# files to /var/www/html/

LOCAL_DIR="/var/www/html/"

/usr/bin/printf "\n${WHITE}\nNow it's time to copy html files from your GIT to your local system${NC}"
start_and_stop_animation dot 2

#read -p "Give username of your REMOTE machine: " USERNAME
# read -p "Give IP address of your REMOTE machine: " IP
# read -p "SSH port number of your REMOTE machine: " PORT
# read -p "Give full path to the html files on your REMOTE machine which will be copied: " REMOTE_DIR

/usr/bin/printf "\n${WHITE}\nThanks!\n\n${NC}"
/usr/bin/printf "${WHITE}Cloning${NC}"
start_and_stop_animation dot 2

/usr/bin/git clone https://github.com/rignellj/Tindog.git "${LOCAL_DIR}/tindog"
/usr/bin/printf "\n${WHITE}\nNow you still need to extract ${LOCAL_DIR}/tindog folder${NC}"
# /usr/bin/scp -r -P "${PORT}" "${USERNAME}"@"${IP}":"${REMOTE_DIR}" "${LOCAL_DIR}"
STATUS_SYMBOLS[10]=${SUCCESS}

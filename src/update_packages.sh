#!/bin/bash

# This script updates packages

WHITE="\033[1;37m"
RESET="\033[0m"

/usr/bin/printf "\n${WHITE}\nUpdating packages...\n${RESET}"
/bin/sleep 2

/usr/bin/sudo apt-get update -y >> /var/log/update.log
/usr/bin/sudo apt-get upgrade -y >> /var/log/update.log

/usr/bin/printf "\n${WHITE}\nLogs in /var/log/update.log\n${RESET}"
/usr/bin/printf "\n${WHITE}\nEnd of the script\n${RESET}"
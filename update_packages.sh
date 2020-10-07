#!/bin/bash

# This script updates packages

WHITE="\033[1;37m"
RESET="\033[0m"

printf "\n${WHITE}\nUpdating packages...\n${RESET}"
sleep 2

apt-get update -y >> /var/log/update.log
apt-get upgrade -y >> /var/log/update.log

printf "\n${WHITE}\nLogs in /var/log/update.log\n${RESET}"
printf "\n${WHITE}\nEnd of the script\n${RESET}"
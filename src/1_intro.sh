#!/bin/bash

# This script updates & upgrades packages and also installs software
# that is needed for this project

# apt install sudo && sudo apt update && sudo apt upgrade

printf "${WHITE}Checking partition${NC}"
start_animation dot
sleep 2
stop_animation

# fdisk -l | grep Linux

echo ""
read -p "Press enter to continue installing: " ENTER

printf "${WHITE}Installing ufw, portsentry, fail2ban, apache2, mailutils packages${NC}"
start_animation dot
sleep 3
stop_animation
# apt-get install ufw portsentry fail2ban apache2 mailutils -y

STATUS_SYMBOLS[0]=${SUCCESS}
STATUS_SYMBOLS[1]=${FAILURE}

echo ""
read -p "Press enter to continue: " ENTER
#!/bin/bash

# This script updates & upgrades packages and also installs software
# that is needed for this project

apt install sudo && sudo apt update && sudo apt upgrade

printf "${WHITE}\nChecking partition${NC}"
start_and_stop_animation dot 2

sudo fdisk -l | grep Linux

read -p "Press enter to continue installing: " ENTER

printf "${WHITE}\nInstalling ufw, portsentry, fail2ban, apache2, mailutils packages${NC}"
start_and_stop_animation dot 3
sudo apt-get install ufw portsentry fail2ban apache2 mailutils -y

STATUS_SYMBOLS[0]=${SUCCESS}
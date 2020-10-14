#!/bin/bash

# This script updates & upgrades packages and also installs software
# that is needed for this project

apt install sudo && /usr/bin/sudo apt update && /usr/bin/sudo apt upgrade

/usr/bin/printf "${WHITE}\nChecking partition${NC}"
start_and_stop_animation dot 2

/usr/bin/sudo fdisk -l | /usr/bin/grep Linux

read -p "Press enter to continue installing: " ENTER

/usr/bin/printf "${WHITE}\nInstalling ufw, portsentry, fail2ban, apache2, mailutils packages${NC}"
start_and_stop_animation dot 3
/usr/bin/sudo apt-get install ufw portsentry fail2ban apache2 mailutils -y

STATUS_SYMBOLS[0]=${SUCCESS}

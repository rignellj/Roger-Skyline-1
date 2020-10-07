#!/bin/bash

# This script updates & upgrades packages and also installs software
# that is needed for this project

apt install sudo && sudo apt update && sudo apt upgrade

printf "\nChecking partition...\n"

sleep 1
fdisk -l | grep Linux

echo ""
read -p "Press enter to continue installing: " ENTER

printf "Installing ufw, portsentry, fail2ban, apache2, mailutils packages...\n"
sleep 3
apt-get install ufw portsentry fail2ban apache2 mailutils -y

echo ""
read -p "Press enter to continue: " ENTER
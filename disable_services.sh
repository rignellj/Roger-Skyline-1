#!/bin/bash

# This script disables unnecessary services

WHITE="\033[1;37m"
RESET="\033[0m"

systemctl disable anacron.service
systemctl disable bluetooth.service
systemctl disable dbus-fi.w1.wpa_supplicant1.service
systemctl disable dbus-org.bluez.service
systemctl disable wpa_supplicant.service
systemctl disable console-setup.service
systemctl disable keyboard-setup.service
systemctl disable apt-daily.timer
systemctl disable apt-daily-upgrade.timer

printf "\n${WHITE}\nCurrent enabled services:\n${RESET}"
sleep 2
systemctl list-unit-files --type service | grep enabled

printf "\n${WHITE}\nEnd of the script\n\n${RESET}"
read -p "Press enter to continue: " ENTER
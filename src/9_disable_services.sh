#!/bin/bash

# This script disables unnecessary services

source ../animation.sh

/usr/bin/echo -ne "Disable unnecessary services"
start_and_stop_animation dot 3

/usr/bin/sudo /usr/bin/systemctl disable anacron.service
/usr/bin/sudo /usr/bin/systemctl disable bluetooth.service
/usr/bin/sudo /usr/bin/systemctl disable dbus-fi.w1.wpa_supplicant1.service
/usr/bin/sudo /usr/bin/systemctl disable dbus-org.bluez.service
/usr/bin/sudo /usr/bin/systemctl disable wpa_supplicant.service
/usr/bin/sudo /usr/bin/systemctl disable console-setup.service
/usr/bin/sudo /usr/bin/systemctl disable keyboard-setup.service
/usr/bin/sudo /usr/bin/systemctl disable apt-daily.timer
/usr/bin/sudo /usr/bin/systemctl disable apt-daily-upgrade.timer

/usr/bin/printf "\n${WHITE}\nCurrent enabled services:\n${NC}"
/bin/sleep 2
/usr/bin/sudo /usr/bin/systemctl list-unit-files --type service | /usr/bin/grep enabled

STATUS_SYMBOLS[7]=${SUCCESS}
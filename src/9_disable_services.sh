#!/bin/bash

# This script disables unnecessary services

echo -ne "Disable unnecessary services"
start_and_stop_animation dot 3

# systemctl disable anacron.service
# systemctl disable bluetooth.service
# systemctl disable dbus-fi.w1.wpa_supplicant1.service
# systemctl disable dbus-org.bluez.service
# systemctl disable wpa_supplicant.service
# systemctl disable console-setup.service
# systemctl disable keyboard-setup.service
# systemctl disable apt-daily.timer
# systemctl disable apt-daily-upgrade.timer

printf "\n${WHITE}\nCurrent enabled services:\n${NC}"
/bin/sleep 2
# systemctl list-unit-files --type service | grep enabled

STATUS_SYMBOLS[7]=${SUCCESS}
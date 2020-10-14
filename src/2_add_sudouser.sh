#!/bin/bash

# This script creates given user and gives sudo privilages to the user.
# It also changes to sudo user which will continue configure

read -p "Give username: " USER
read -p "Give scripts folder name: " FOLDER

SCRIPTS="/root/${FOLDER}"
USER_DIR="/home/${USER}/"

/usr/bin/sudo adduser ${USER}
/usr/bin/sudo adduser ${USER} /usr/bin/sudo
ADDSUDO=$?

if [ $ADDSUDO = "0" ]
then
	/usr/bin/echo "${USER} added to sudoers."
	STATUS_SYMBOLS[1]=${SUCCESS}
else
	STATUS_SYMBOLS[1]=${ATTENTION}
	/usr/bin/echo "Failure."
	return 1
fi

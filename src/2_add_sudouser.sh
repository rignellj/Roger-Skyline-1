#!/bin/bash

# This script creates given user and gives sudo privilages to the user.
# It also changes to sudo user which will continue configure

read -p "Give username: " USER
read -p "Give scripts folder name: " FOLDER

SCRIPTS="/root/${FOLDER}"
USER_DIR="/home/${USER}/"

adduser ${USER}
adduser ${USER} sudo
ADDSUDO=$?

if [ $ADDSUDO = "0" ]
then
	echo "${USER} added to sudoers."
	STATUS_SYMBOLS[1]=${SUCCESS}
else
	STATUS_SYMBOLS[1]=${ATTENTION}
	echo "Failure."
	return 1
fi

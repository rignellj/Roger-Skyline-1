#!/bin/bash

# This script creates given user and gives sudo privilages to the user.
# It also changes to sudo user which will continue configure

WHITE='\033[1;37m'
RESET='\033[0m'
SCRIPTS="/root/scripts"

read -p "Give username: " USER

USER_DIR="/home/${USER}/"

adduser ${USER}
adduser ${USER} sudo
ADDSUDO=$?

if [ $ADDSUDO -eq "0" ]
then
	echo "${USER} added to sudoers."
	printf "${WHITE}\nChanging user...\n${RESET}"
	chown -R ${USER} ${SCRIPTS}
	mv ${SCRIPTS} ${USER_DIR}
	su ${USER}
else
	echo "Failure."
fi

echo "End of the script."
read -p "Press enter to continue: " ENTER
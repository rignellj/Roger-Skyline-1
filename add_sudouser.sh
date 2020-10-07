#!/bin/bash

# This script creates given user and gives sudo privilages to the user

read -p "Give username: " USER

adduser ${USER}
sudo adduser ${USER} sudo
ADDSUDO=$?

if [ $ADDSUDO -eq "0" ]
then
	echo "${USER} added to sudoers."
else
	echo "Failure."
fi

echo "End of the script."
read -p "Press enter to continue: " ENTER

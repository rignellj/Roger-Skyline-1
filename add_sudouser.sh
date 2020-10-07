#!/bin/bash
read -p "Give username: " USER

sudo adduser ${USER}
ADDUSER=$?

LAST_PID=$!
wait ${LAST_PID}

sudo adduser ${USER} sudo
ADDSUDO=$?

LAST_PID=$!
wait ${LAST_PID}

if [ $ADDUSER -eq "0" ]
then
	echo "User created"
else
	echo "Could not create new user. Exiting 1..."
	exit 1
fi

if [ $ADDSUDO -eq "0" ]
then
	echo "${USER} added to sudoers."
else
	echo "Failure."
fi

echo "End of the script."
read -p "Press enter to continue: " ENTER

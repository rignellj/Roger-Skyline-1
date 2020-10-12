#!/bin/bash

CONF_F="/etc/ssh/sshd_config"
read -p "Have you already added public key to server? Answer 'yes' or 'no': " ANSWER

case $ANSWER in
	[yY]|[yY][eE][sS])
		echo "Continue"
		;;
	[nN]|[nN][oO])
		echo "Run command 'ssh-keygen' to generate new ssh key"
		echo "Then 'ssh-copy-id -i /path/to/.ssh/id_rsa.pub <username>@<hostname>' to add your public key to server"
		echo 'After these steps run again this script.'
		echo "Exiting script."
		exit 1
	;;
	*)
		echo "Exiting."
		exit 1
	;;
esac

read -p "Give new ssh port to use: " PORT

if [ ! -s ${CONF_F}.bak ]
then
	sed -i.bak '/Port/d ; /PasswordAuthentication/d ; /PermitRootLogin/d' ${CONF_F}
	wait $($!)
	echo "Port ${PORT}" >> ${CONF_F}
	echo "PasswordAuthentication no" >> ${CONF_F}
	echo "PermitRootLogin no" >> ${CONF_F}
else 
	echo "sshd.bak already exists."
fi

echo "Restarting sshd: "
sleep 1
service sshd restart

echo "Checking status: "
sleep 1
service sshd status

echo "Now users can only use their public keys to authenticate"
echo ""

read -p "Press enter to continue: " ENTER
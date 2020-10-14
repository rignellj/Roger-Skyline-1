#!/bin/bash

source ../animation.sh

CONF_F="/etc/ssh/sshd_config"
read -p "Have you already added public key to server? Answer 'yes' or 'no': " ANSWER

case $ANSWER in
	[yY]|[yY][eE][sS])
		/usr/bin/echo "Continue"
		;;
	[nN]|[nN][oO])
		/usr/bin/echo "Run command 'ssh-keygen' to generate new ssh key"
		/usr/bin/echo "Then 'ssh-copy-id -i /path/to/.ssh/id_rsa.pub <username>@<hostname>' to add your public key to server"
		/usr/bin/echo 'After these steps run again this script.'
		/usr/bin/echo "Exiting script."
		exit 1
	;;
	*)
		/usr/bin/echo "Exiting 1."
		exit 1
	;;
esac

read -p "Give new ssh port to use: " PORT

if [ ! -s ${CONF_F}.bak ]
then
	/usr/bin/echo -ne "Making changes to config ${CONF_F}"
	start_and_stop_animation dot 3
	/usr/bin/sudo /usr/bin/sed -i.bak '/Port/d ; /PasswordAuthentication/d ; /PermitRootLogin/d' ${CONF_F}
	/usr/bin/echo "Port ${PORT}" >> ${CONF_F}
	/usr/bin/echo "PasswordAuthentication no" >> ${CONF_F}
	/usr/bin/echo "PermitRootLogin no" >> ${CONF_F}
else 
	/usr/bin/echo "${CONF_F}.bak already exists."
fi

/usr/bin/echo "Restarting sshd: "
/bin/sleep 1
/usr/bin/sudo service sshd restart

/usr/bin/echo "Checking ssh status: "
/bin/sleep 1
/usr/bin/sudo service sshd status

/usr/bin/echo "Now users can only use their public keys to authenticate"
STATUS_SYMBOLS[3]=${SUCCESS}

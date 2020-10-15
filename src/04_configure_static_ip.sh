#!/bin/bash

source ../animation.sh

PATH="/etc/network/interfaces.d"
FILE="enp0s3"

read -p "IP Address: " IP
read -p "Netmask: " NETMASK
read -p "Gateway: " GATEWAY

/usr/bin/echo "Updating config file ${PATH}/${FILE}"

if [ ! -s ${PATH}/${FILE} ]
then
	/usr/bin/echo -ne "Creating ${FILE}"
	start_and_stop_animation dot 2
	/usr/bin/echo "iface ${FILE} inet static" > ${PATH}/${FILE}
	/usr/bin/echo "	address ${IP}" >> ${PATH}/${FILE}
	/usr/bin/echo "	netmask ${NETMASK}" >> ${PATH}/${FILE}
	/usr/bin/echo "	gateway ${GATEWAY}" >> ${PATH}/${FILE}
else
	/usr/bin/echo "Config file already exists."
fi

/usr/bin/echo "Restarting network"
/usr/bin/sudo service networking restart

/usr/bin/echo "Info about network interfaces:"
/bin/sleep 2
/usr/bin/echo ""
/usr/bin/ip a | /usr/bin/grep enp0s3

STATUS_SYMBOLS[2]=${SUCCESS}

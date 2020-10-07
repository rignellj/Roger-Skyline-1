#!/bin/bash

PATH="/etc/network/interfaces.d"
FILE="enp0s3"

read -p "IP Address: " IP
read -p "Netmask: " NETMASK
read -p "Gateway: " GATEWAY

echo "Updating config file ${PATH}/${FILE}"

if [ ! -s ${PATH}/${FILE} ]
then
	echo "Creating ${FILE}..."
	echo "iface ${FILE} inet static" > ${PATH}/${FILE}
	echo "	address ${IP}" >> ${PATH}/${FILE}
	echo "	netmask ${NETMASK}" >> ${PATH}/${FILE}
	echo "	gateway ${GATEWAY}" >> ${PATH}/${FILE}
else
	echo "Config file already exists."
fi

echo "Restart network running 'sudo service networking restart'"
echo "Run 'ip a | grep enp0s3' to get info about network interfaces"
echo ""

read -p "Press enter to continue: " ENTER

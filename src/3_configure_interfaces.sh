#!/bin/bash

INTERFACE="/etc/network/interfaces"
echo -ne "Updating interfaces config files"
start_and_stop_animation dot 2

if [ -s ${INTERFACE}.bak ]
then
	printf "${WHITE}\nBackup file exists.${NC}"
else
	sudo sed -i.bak "s/allow-hotplug enp0s3/auto enp0s3/ ; /iface enp0s3 inet dhcp/d" ${INTERFACE}
	printf "${WHITE}\nConfig file updated. Backup file was created.\n\n${NC}"
fi

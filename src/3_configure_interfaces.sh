#!/bin/bash

local INTERFACE="/etc/network/interfaces"
echo "Updating interfaces config files"

if [ -s ${INTERFACE}.bak ]
then
	echo "Backup file exists."
else
	sed -i.bak "s/allow-hotplug enp0s3/auto enp0s3/ ; /iface enp0s3 inet dhcp/d" ${INTERFACE}
	wait $($!)
	echo "Config file updated. Backup file was created."
fi

echo ""

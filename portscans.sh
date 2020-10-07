#!/bin/bash

# This script configures file /etc/default/portsentry

WHITE="\033[1;37m"
RESET="\033[0m"
RED="\033[1;31m"
FILE="/etc/default/portsentry"
CONF_F="/etc/portsentry/portsentry.conf"

printf "\n${WHITE}\nConfigure ${FILE}...\n${RESET}"
sleep 2

if [ ! -s ${FILE}.bak ]
then
	printf "${WHITE}Continue...\n${RESET}"
	sleep 2
else
	printf "${RED}Backup file exists. Exiting with exit status 1...\n${RESET}"
	exit 1
fi

printf "\n${WHITE}\nCreating backup file ${FILE}.bak and making edits...\n${RESET}"
sleep 2

sed -i.bak "s/TCP_MODE=\"tcp\"/TCP_MODE=\"atcp\"/" ${FILE}
sed -i "s/UDP_MODE=\"udp\"/UDP_MODE=\"audp\"/" ${FILE}

printf "\n${WHITE}\nCreating backup file ${CONF_F}.bak and making edits...\n${RESET}"
sleep 2

sed -i.bak "s/BLOCK_UDP=\"1\"/BLOCK_UDP=\"1\"/" ${CONF_F}
sed -i "s/BLOCK_TCP=\"1\"/BLOCK_TCP=\"1\"/" ${CONF_F}
sed -i "170 s/^#*/#/p" ${CONF_F}
sed -i "209 s/^#//p" ${CONF_F}

printf "\n${WHITE}\nRestarting service...\n${RESET}"
service portsentry restart

printf "\n${WHITE}\nStatus of portsentry:\n${RESET}"
sleep 2
service portsentry status

printf "\n${WHITE}\nYou can check which ports are open running 'lsof -i -P'\n${RESET}"

printf "\n${WHITE}\nEnd of the script\n\n${RESET}"
read -p "Press enter to continue: " ENTER

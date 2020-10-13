#!/bin/bash

# This script configures file /etc/default/portsentry

echo -ne "Protection Against Port Scans"
start_and_stop_animation dot 3

FILE="/etc/default/portsentry"
CONF_F="/etc/portsentry/portsentry.conf"

printf "\n${WHITE}\nConfigure ${FILE}${NC}"
start_and_stop_animation dot 2

if [ ! -s ${FILE}.bak ]
then
	printf "\n${WHITE}Continue${NC}"
	start_and_stop_animation dot 2
else
	printf "\n${RED}Backup file exists. Exiting with exit status 1...\n${NC}"
	STATUS_SYMBOLS[6]=${ATTENTION}
	return 1
fi

printf "\n${WHITE}\nCreating backup file ${FILE}.bak and making edits${NC}"
start_and_stop_animation dot 2

sed -i.bak "s/TCP_MODE=\"tcp\"/TCP_MODE=\"atcp\"/" ${FILE}
sed -i "s/UDP_MODE=\"udp\"/UDP_MODE=\"audp\"/" ${FILE}

printf "\n${WHITE}\nCreating backup file ${CONF_F}.bak and making edits${NC}"
start_and_stop_animation dot 2

sed -i.bak "s/BLOCK_UDP=\"1\"/BLOCK_UDP=\"1\"/" ${CONF_F}
sed -i "s/BLOCK_TCP=\"1\"/BLOCK_TCP=\"1\"/" ${CONF_F}
sed -i "170 s/^#*/#/p" ${CONF_F}
sed -i "209 s/^#//p" ${CONF_F}

printf "\n${WHITE}\nRestarting service:\n${NC}"
/bin/sleep 1
service portsentry restart

printf "\n${WHITE}\nStatus of portsentry:\n${NC}"
/bin/sleep 2
service portsentry status

printf "\n${WHITE}\nYou can check which ports are open running 'lsof -i -P'\n${NC}"
STATUS_SYMBOLS[6]=${SUCCESS}

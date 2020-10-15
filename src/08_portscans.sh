#!/bin/bash

# This script configures file /etc/default/portsentry

/usr/bin/echo -ne "Protection Against Port Scans"
start_and_stop_animation dot 3

FILE="/etc/default/portsentry"
CONF_F="/etc/portsentry/portsentry.conf"

/usr/bin/printf "\n${WHITE}\nConfigure ${FILE}${NC}"
start_and_stop_animation dot 2

if [ ! -s ${FILE}.bak ]
then
	/usr/bin/printf "\n${WHITE}Continue${NC}"
	start_and_stop_animation dot 2
else
	/usr/bin/printf "\n${RED}Backup file exists. Exiting with exit status 1...\n${NC}"
	STATUS_SYMBOLS[6]=${ATTENTION}
	return 1
fi

/usr/bin/printf "\n${WHITE}\nCreating backup file ${FILE}.bak and making edits${NC}"
start_and_stop_animation dot 2

/usr/bin/sudo /usr/bin/sed -i.bak "s/TCP_MODE=\"tcp\"/TCP_MODE=\"atcp\"/" ${FILE}
/usr/bin/sudo /usr/bin/sed -i "s/UDP_MODE=\"udp\"/UDP_MODE=\"audp\"/" ${FILE}

/usr/bin/printf "\n${WHITE}\nCreating backup file ${CONF_F}.bak and making edits${NC}"
start_and_stop_animation dot 2

/usr/bin/sudo /usr/bin/sed -i.bak "s/BLOCK_UDP=\"1\"/BLOCK_UDP=\"1\"/" ${CONF_F}
/usr/bin/sudo /usr/bin/sed -i "s/BLOCK_TCP=\"1\"/BLOCK_TCP=\"1\"/" ${CONF_F}
/usr/bin/sudo /usr/bin/sed -i "170 s/^#*/#/p" ${CONF_F}
/usr/bin/sudo /usr/bin/sed -i "209 s/^#//p" ${CONF_F}

/usr/bin/printf "\n${WHITE}\nRestarting service:\n${NC}"
/bin/sleep 1
/usr/bin/sudo service portsentry restart

/usr/bin/printf "\n${WHITE}\nStatus of portsentry:\n${NC}"
/bin/sleep 2
/usr/bin/sudo service portsentry status

/usr/bin/printf "\n${WHITE}\nYou can check which ports are open running '/usr/bin/lsof -i -P'\n${NC}"
STATUS_SYMBOLS[6]=${SUCCESS}

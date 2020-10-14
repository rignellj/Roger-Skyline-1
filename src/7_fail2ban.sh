#!/bin/bash

# This script performs additions to fail2ban.config file
# and creates backup file of the original file

/usr/bin/echo -ne "Configure Denial Of Service Attack (DOS)"
start_and_stop_animation dot 3

PORT_LINE=$(/usr/bin/sudo /usr/bin/sed -n "/Port /p" /etc/ssh/sshd_config)
PORT=$(/usr/bin/echo ${PORT_LINE} | /usr/bin/cut -d' ' -f 2)
CONF_F="/etc/fail2ban/jail.conf"
DOS_CONF_F="/etc/fail2ban/filter.d/http-get-dos.conf"

if [ ! -s ${CONF_F}.bak ]
then
	/usr/bin/printf "${WHITE}Continue${NC}"
	start_and_stop_animation dot 2
else
	/usr/bin/printf "${RED}Backup file exists. Returning with exit status 1...\n${NC}"
	STATUS_SYMBOLS[5]=${ATTENTION}
	return 1
fi

/usr/bin/printf "\n${WHITE}Default settings:\n\n${NC}"

read -p "Bantime (in seconds): " DEF_BANTIME
read -p "Findtime (in seconds): " DEF_FINDTIME
read -p "Maximum times of retry: " DEF_MAXRETRY

/usr/bin/sudo /usr/bin/sed -i.bak "/^\[DEFAULT\]/,/^\[sshd\]/ s/^bantime  = 10m/bantime = ${DEF_BANTIME}/ ;\
		/^\[DEFAULT\]/,/^\[sshd\]/ s/^findtime  = 10m/findtime = ${DEF_FINDTIME}/ ;\
		/^\[DEFAULT\]/,/^\[sshd\]/ s/^maxretry = 5/maxretry = ${DEF_MAXRETRY}/" ${CONF_F}

/usr/bin/printf "\n${WHITE}\nSSH settings:\n${NC}"

/usr/bin/sudo /usr/bin/sed -i "/^\[sshd\]/a enabled = true/p" ${CONF_F}
/usr/bin/sudo /usr/bin/sed -i "/^\[sshd\]/,/^\[dropbear\]/ s/port    = ssh/port = ${PORT}/" ${CONF_F} 

/usr/bin/sudo /usr/bin/sed -n "/^\[sshd\]/,/^\[dropbear\]/ s/ / /" ${CONF_F}

/usr/bin/printf "\n${WHITE}\nSetting up DOS${NC}"
start_and_stop_animation dot 3

/usr/bin/echo "[http-get-dos]
enabled = true
filter = http-get-dos
logpath = /var/log/apache2/access.log
maxretry = 15
findtime = 5m
bantime = 10m
action = iptables[name=HTTP, port=http, protocol=tcp]" >> ${CONF_F}

/usr/bin/printf "\n${WHITE}\nCreating DOS file${NC}"
start_and_stop_animation dot 3

/usr/bin/echo "[Definition]
failregex = ^<HOST> -.*\"(GET|POST).*
ignoreregex =" > ${DOS_CONF_F}

/usr/bin/printf "\n${WHITE}\nRestarting service:\n${NC}"
/usr/bin/sudo ufw reload
/usr/bin/sudo service fail2ban restart
/usr/bin/sudo /usr/bin/systemctl enable fail2ban

/usr/bin/printf "\n${WHITE}\nStatus of fail2ban:\n${NC}"
/bin/sleep 2

/usr/bin/sudo /usr/bin/systemctl status fail2ban

/usr/bin/printf "\n${WHITE}\nsudo iptables -L:\n${NC}"
/bin/sleep 2

/usr/bin/sudo iptables -L

/usr/bin/printf	"\n${WHITE}\nNow you can test server by '<wrong-username>@<hostname>' \
and check 'sudo fail2ban-client status sshd' filter and action status\n${NC}"
/usr/bin/printf	"\n${WHITE}\nRun 'sudo tail -f /var/log/fail2ban.log' to see which IPs have been blocked to use ssh\n${NC}"

STATUS_SYMBOLS[5]=${SUCCESS}

#!/bin/bash

# This script performs additions to fail2ban.config file
# and creates backup file of the original file

WHITE='\033[1;37m'
RED='\033[1;31m'
RESET='\033[0m'

PORT_LINE=$(sed -n "/Port /p" /etc/ssh/sshd_config)
PORT=$(echo ${PORT_LINE} | cut -d' ' -f 2)
CONF_F="/etc/fail2ban/jail.conf"
DOS_CONF_F="/etc/fail2ban/filter.d/http-get-dos.conf"

if [ ! -s ${CONF_F}.bak ]
then
	printf "${WHITE}Continue...\n${RESET}"
	sleep 2

else
	printf "${RED}Backup file exists. Exiting with exit status 1...\n${RESET}"
	exit 1
fi

printf "\n${WHITE}Default settings:\n\n${RESET}"

read -p "Bantime (in seconds): " DEF_BANTIME
read -p "Findtime (in seconds): " DEF_FINDTIME
read -p "Maximum times of retry: " DEF_MAXRETRY

sed -i.bak "/^\[DEFAULT\]/,/^\[sshd\]/ s/^bantime  = 10m/bantime = ${DEF_BANTIME}/ ;\
		/^\[DEFAULT\]/,/^\[sshd\]/ s/^findtime  = 10m/findtime = ${DEF_FINDTIME}/ ;\
		/^\[DEFAULT\]/,/^\[sshd\]/ s/^maxretry = 5/maxretry = ${DEF_MAXRETRY}/" ${CONF_F}

printf "\n${WHITE}\nSSH settings:\n${RESET}"

sed -i "/^\[sshd\]/a enabled = true/p" ${CONF_F}
sed -i "/^\[sshd\]/,/^\[dropbear\]/ s/port    = ssh/port = ${PORT}/" ${CONF_F} 

sed -n "/^\[sshd\]/,/^\[dropbear\]/ s/ / /" ${CONF_F}

printf "\n${WHITE}\nSetting up DOS...\n${RESET}"
sleep 2

echo "[http-get-dos]
enabled = true
filter = http-get-dos
logpath = /var/log/apache2/access.log
maxretry = 15
findtime = 5m
bantime = 10m
action = iptables[name=HTTP, port=http, protocol=tcp]" >> ${CONF_F}

printf "\n${WHITE}\nCreating DOS file...\n${RESET}"
sleep 2

echo "[Definition]
failregex = ^<HOST> -.*\"(GET|POST).*
ignoreregex =" > ${DOS_CONF_F}

printf "\n${WHITE}\nRestarting service...\n${RESET}"
ufw reload
service fail2ban restart
systemctl enable fail2ban

printf "\n${WHITE}\nStatus of fail2ban:\n${RESET}"
sleep 2

systemctl status fail2ban

printf "\n${WHITE}\nsudo iptables -L:\n${RESET}"
sleep 2

iptables -L

printf	"\n${WHITE}\nNow you can test server by '<wrong-username>@<hostname>' \
and check 'sudo fail2ban-client status sshd' filter and action status\n${RESET}"
printf	"\n${WHITE}\nRun 'sudo tail -f /var/log/fail2ban.log' to see which IPs have been blocked to use ssh\n${RESET}"

printf "\n${WHITE}\nEnd of the script\n\n${RESET}"
read -p "Press enter to continue: " ENTER

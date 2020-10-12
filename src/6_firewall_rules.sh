#!/bin/bash

WHITE='\033[1;37m'
RESET='\033[0m'

PORT_LINE=$(sed -n "/Port /p" /etc/ssh/sshd_config)
PORT=$(echo ${PORT_LINE} | cut -d' ' -f 2)

ufw default deny incoming
ufw default allow outgoing
ufw allow https #OR ufw allow 443
ufw allow 80/tcp
ufw allow ${PORT}/tcp

printf "${WHITE}\nStatus table:\n${RESET}"
sleep 1
ufw status verbose

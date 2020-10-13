#!/bin/bash

# This script configures firewall rules

echo -ne "Configure firewall rules"
start_and_stop_animation dot 3

PORT_LINE=$(sed -n "/Port /p" /etc/ssh/sshd_config)
PORT=$(echo ${PORT_LINE} | cut -d' ' -f 2)

ufw default deny incoming
ufw default allow outgoing
ufw allow https #OR ufw allow 443
ufw allow 80/tcp
ufw allow ${PORT}/tcp

printf "${WHITE}\nStatus table:\n${NC}"
/bin/sleep 1
ufw status verbose

STATUS_SYMBOLS[4]=${SUCCESS}

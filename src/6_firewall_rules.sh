#!/bin/bash

# This script configures firewall rules

source ../animation.sh

/usr/bin/echo -ne "Configure firewall rules"
start_and_stop_animation dot 3

PORT_LINE=$(/usr/bin/sudo /usr/bin/sed -n "/Port /p" /etc/ssh/sshd_config)
PORT=$(/usr/bin/echo ${PORT_LINE} | /usr/bin/cut -d' ' -f 2)

/usr/bin/sudo ufw default deny incoming
/usr/bin/sudo ufw default allow outgoing
/usr/bin/sudo ufw allow https #OR ufw allow 443
/usr/bin/sudo ufw allow 80/tcp
/usr/bin/sudo ufw allow ${PORT}/tcp

/usr/bin/printf "${WHITE}\nStatus table:\n${NC}"
/bin/sleep 1
/usr/bin/sudo ufw status verbose

STATUS_SYMBOLS[4]=${SUCCESS}

#!/bin/bash

# This script detects modifications in crontab file

WHITE="\033[1;37m"
RESET="\033[0m"

CRON="/etc/crontab"
BAK="/etc/crontab.bak"
DIFF=$(/usr/bin/diff /etc/crontab.bak /etc/crontab)

if [ ! -s "${BAK}" ]
then
	/usr/bin/printf "\n${WHITE}\nCrontab backup file doesn't exist. Creating one...\n${RESET}"
	/bin/sleep 2
	/usr/bin/cat "${CRON}" > "${BAK}"
	/usr/bin/printf "\n${WHITE}\nExiting with status 0\n${RESET}"
	exit 0
fi

/usr/bin/cat "${CRON}" > "${BAK}"

if [ "${DIFF}" != "" ]
then
	/usr/bin/echo "Crontab Check" | /usr/bin/mail -s "Crontab modified" "root@$(/usr/bin/hostname)"
fi

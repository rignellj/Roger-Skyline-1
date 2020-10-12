#!/bin/bash

# This script detects modifications in crontab file

WHITE="\033[1;37m"
RESET="\033[0m"

CRON="/etc/crontab"
BAK="/etc/crontab.bak"
DIFF=$(diff /etc/crontab.bak /etc/crontab)

if [ ! -s "${BAK}" ]
then
	printf "\n${WHITE}\nCrontab backup file doesn't exist. Creating one...\n${RESET}"
	sleep 2
	cat "${CRON}" > "${BAK}"
	printf "\n${WHITE}\nExiting with status 0\n${RESET}"
	exit 0
fi

cat "${CRON}" > "${BAK}"

if [ "${DIFF}" != "" ]
then
	echo "Crontab Check" | mail -s "Crontab modified" root@roger
fi

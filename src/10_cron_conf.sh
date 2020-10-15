#!/bin/bash

# This script adds few tasks to crontab file

read -p "Type username to whom cron jobs to configure. User should have sudo privilages: " ANSWER

/usr/bin/echo -ne "Add few tasks to crontab file"
start_and_stop_animation dot 3

UPDATE_4AM="0 4 * * 0 sudo /root/scripts/src/update_packages.sh"
UPDATE_AT_REBOOT="@reboot sudo /root/scripts/src/update_packages.sh"
MONITOR_CRON="0 0 * * * sudo /root/scripts/src/cron_monitor.sh"

/usr/bin/sudo /usr/bin/crontab -u ${ANSWER} -e
(/usr/bin/sudo /usr/bin/crontab -u ${ANSWER} -l; /usr/bin/echo "${UPDATE_4AM}" )| /usr/bin/sudo /usr/bin/crontab -u ${ANSWER} -
(/usr/bin/sudo /usr/bin/crontab -u ${ANSWER} -l; /usr/bin/echo "${UPDATE_AT_REBOOT}") | /usr/bin/sudo /usr/bin/crontab -u ${ANSWER} -
(/usr/bin/sudo /usr/bin/crontab -u ${ANSWER} -l; /usr/bin/echo "${MONITOR_CRON}") | /usr/bin/sudo /usr/bin/crontab -u ${ANSWER} -

STATUS_SYMBOLS[8]=${SUCCESS}

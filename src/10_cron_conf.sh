#!/bin/bash

# This script adds few tasks to crontab file

UPDATE_4AM="0 4 * * 0 sudo /home/admin/scripts/update_packages.sh"
UPDATE_AT_REBOOT="@reboot sudo /home/admin/scripts/update_packages.sh"
MONITOR_CRON="0 0 * * * sudo /home/admin/scripts/cron_monitor.sh"

(crontab -u $(whoami) -l; echo "${UPDATE_4AM}" )| crontab -u $(whoami) -
(crontab -u $(whoami) -l; echo "${UPDATE_AT_REBOOT}") | crontab -u $(whoami) -
(crontab -u $(whoami) -l; echo "${MONITOR_CRON}") | crontab -u $(whoami) -

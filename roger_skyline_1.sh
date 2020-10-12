#!/bin/bash

# This script configures everything that is needed for web server.

function status() {
	printf "${NC}\n"
	printf "${STATUS_SYMBOLS[0]}	Introduction\n"
	printf "${STATUS_SYMBOLS[1]}	Creating Nonroot User\n"
	printf "${STATUS_SYMBOLS[2]}	Configure a Static IP\n"
	printf "${STATUS_SYMBOLS[3]}	Change the SSH Default Port and Setup SSH Access With Publickeys\n"
	printf "${STATUS_SYMBOLS[4]}	Firewall Setup With UFW\n"
	printf "${STATUS_SYMBOLS[5]}	DOS (Denial Of Service Attack) protection\n"
	printf "${STATUS_SYMBOLS[6]}	Protection Against Port Scans\n"
	printf "${STATUS_SYMBOLS[7]}	Disable the Services We Don’t Need\n"
	printf "${STATUS_SYMBOLS[8]}	Update Packages Script\n"
	printf "${STATUS_SYMBOLS[9]}	Monitor Crontab Changes Script\n"
	printf "${STATUS_SYMBOLS[10]}	Self-signed SSL and Debloyment\n"
	printf "${STATUS_SYMBOLS[11]}	Deployment Automation\n"
}

###############################################################
# SCRIPT PART BEGINS AFTER THIS                               #
###############################################################

source animation.sh

source src/1_intro.sh
status
# source src/2_add_sudouser.sh
# source src/3_configure_interfaces.sh
# source src/4_configure_static_ip.sh
# source src/5_ssh_configure.sh
# source src/6_firewall_rules.sh
# source src/7_fail2ban.sh
# source src/8_portscans.sh
# source src/9_disable_services.sh
# source src/10_cron_conf.sh
# source src/11_web_server_deployment.sh
# source src/12_files_copy.sh

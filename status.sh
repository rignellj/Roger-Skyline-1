#!/bin/bash

function status() {
	printf "\n${NC}Checking status:\n"
	start_and_stop_animation spin $1
	printf "${NC}\r"
	printf "${STATUS_SYMBOLS[0]}	Introduction\n"
	printf "${STATUS_SYMBOLS[1]}	Creating Nonroot User\n"
	printf "${STATUS_SYMBOLS[2]}	Configure a Static IP\n"
	printf "${STATUS_SYMBOLS[3]}	Change the SSH Default Port and Setup SSH Access With Publickeys\n"
	printf "${STATUS_SYMBOLS[4]}	Firewall Setup With UFW\n"
	printf "${STATUS_SYMBOLS[5]}	DOS (Denial Of Service Attack) protection\n"
	printf "${STATUS_SYMBOLS[6]}	Protection Against Port Scans\n"
	printf "${STATUS_SYMBOLS[7]}	Disable the Services We Don’t Need\n"
	printf "${STATUS_SYMBOLS[8]}	Update Packages & Monitor Crontab Changes Scripts\n"
	printf "${STATUS_SYMBOLS[9]}	Self-signed SSL and Debloyment\n"
	printf "${STATUS_SYMBOLS[10]}	Deployment Automation\n"
	echo ""
	read -p "Press enter to continue: " ENTER
	echo ""
}

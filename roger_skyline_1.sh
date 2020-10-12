#!/bin/bash

# This script configures everything that is needed for web server.

SPINNER=( '|' '/' '-' '\' '|' '\' '-' '/' '|' '/' '-' '\' '|' )

BLACK='\033[1;30m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

COLORS=( ${BLACK} ${RED} ${GREEN} ${YELLOW} ${BLUE} ${PURPLE} ${CYAN} ${WHITE} )

function spin() {
	while [ 1 ]
	do
		for COLOR in "${COLORS[@]}"
		do
			printf ${COLOR}
			for CHAR in "${SPINNER[@]}"
			do
				echo -ne "\r${CHAR}"
				sleep 0.2
			done
		done
	done
}

function start_spin() {
	spin &
	SPIN_PID=$!
	trap 'kill $SPIN_PID' SIGTERM SIGKILL
}

function stop_spin() {
	kill ${SPIN_PID}
}

function intro() {
	start_spin

	for NUM in 1 2 3 4
	do
		sleep 2
	done

	stop_spin
	status
}

function status() {
	printf "${NC}\n"
	printf "[\xe2\x9c\x98] Introduction\n"
	printf "[ ] Creating Nonroot User\n"
	printf "[\xe2\x9c\x98] Configure a Static IP\n"
	printf "[\xe2\x9c\x98] Change the SSH Default Port and Setup SSH Access With Publickeys\n"
	printf "[\xe2\x9c\x98] Firewall Setup With UFW\n"
	printf "[\xe2\x9c\x98] DOS (Denial Of Service Attack) protection\n"
	printf "[\xe2\x9c\x98] Protection Against Port Scans\n"
	printf "[\xe2\x9c\x98] Disable the Services We Don’t Need\n"
	printf "[\xe2\x9c\x98] Update Packages Script\n"
	printf "[\xe2\x9c\x98] Monitor Crontab Changes Script\n"
	printf "[\xe2\x9c\x98] Self-signed SSL and Debloyment\n"
	printf "[\xe2\x9c\x98] Deployment Automation\n"
}


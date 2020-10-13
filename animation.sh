#!/bin/bash

# This file consist animation components

SPINNER=( '|' '/' '-' '\' '|' '\' '-' '/' '|' '/' '-' '\' '|' )

STATUS_SYMBOLS=( "" "" "" "" "" "" "" "" "" "" "" "" )

BLACK='\033[1;30m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

SUCCESS="${GREEN}[\xe2\x9c\x94]${NC}"
FAILURE="${RED}[\xe2\x9c\x98]${NC}"
ATTENTION="${YELLOW}[!]${NC}"

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
				/bin/sleep 0.2
			done
		done
	done
}

function dot() {
	while [ 1 ]
	do
		echo -ne "."
		/bin/sleep 0.2
	done
}

function start_and_stop_animation() {
	$1 &
	ANIMATION_PID=$!
	trap 'kill $ANIMATION_PID' SIGTERM SIGKILL
	/bin/sleep $2
	kill ${ANIMATION_PID}
	if [ $1 = "dot" ]
	then
		echo ""
	fi
}

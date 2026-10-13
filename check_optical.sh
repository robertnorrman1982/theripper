#!/usr/bin/env bash

FILES_DIR="./files"
USER_ID="$( id -u )"
DIR_OWNER="$( stat ./ | grep $USER_ID )"
if [[ -n $DIR_OWNER ]]; then 
	ACCESS=true
else
	ACCESS=false
fi

if [[ $ACCESS ]]; then
	echo "The user has access."
else
	echo "The user has no access!"
fi


if [[ -d "$FILES_DIR" ]]; then 
	echo "Directory exists."
else
	if [[ $ACCESS ]]; then
	mkdir "$FILES_DIR"
	fi
fi

	if [[ true ]]; then 
		:
	fi

	clear
OPTICAL="$( lsblk | grep "rom" | grep sr[0-9] | cat -n | tail -n 1 | tr -s " " "#" | sed 's/#//' | grep -o -- ^[0-9] )"
if [[ $OPTICAL > 1 ]]; then
	SUFFIX="s"
fi

# test >>>
# DRIVES=$OPTICAL
# declare -i DRIVES

echo "You have $OPTICAL read-only drive$SUFFIX."

DRIVE_0="$( lsblk | grep sr[0-9] -o | head -1 )"
DRIVE_0_DIR="/dev/$DRIVE_0"
DRIVE_0_INFO="$( lsblk | grep sr[0-9] | head -1 )"
DRIVE_0_TYPE_AND_DIRECTORY="$( echo "$DRIVE_0_INFO" | grep "rom".*$ -o )"
DRIVE_0_DIRECTORY="$( echo $DRIVE_0_TYPE_AND_DIRECTORY | sed 's/rom//' | cut -d " " -f 2 )"

if [[ -n "$DRIVE_0_DIRECTORY" ]]; then
	DRIVE_0_M_DESC="mounted"
	DRIVE_0_MOUNTED=true
else
	DRIVE_0_M_DESC="not mounted"
	DRIVE_0_MOUNTED=false
fi

echo "Drive 0 is $DRIVE_0_M_DESC."

if [[ $DRIVE_0_MOUNTED ]]; then 
	DRIVE_0_DESCRIPTION="$( lsdvd $DRIVE_0_DIR )"
	DRIVE_0_TITLE="$( echo "$DRIVE_0_DESCRIPTION" | grep "Disc Title: ".*$ | tr -s " " "\t" | cut -f 3 )"
fi

if [[ -n $DRIVE_0_DESCRIPTION ]]; then 
	echo "There's a DVD in your drivebay. The simplified title of the movie is $DRIVE_0_TITLE."
fi

if [[ 1 == 2 ]]; then
	eject $DRIVE_0
fi

#!/bin/bash
#Backup script

SOURCE_DIR="/home/ubuntu/IMP_DAILY_TASK/IMP_DAILY_TASK/LINUX"

if [[ ! -d "$SOURCE_DIR" ]]; then
	echo "source dir not present....exiting...."
	exit 1
fi
BACKUP_DIR="/home/ubuntu/IMP_DAILY_TASK/IMP_DAILY_TASK/"
TIMESTAMP=$(date '+%Y_%m_%d-%H_%M_%S')
mkdir -p "$BACKUP_DIR"
BACKUP_FILE="linux_backup_$TIMESTAMP.tar.gz"

tar -cvzf "$BACKUP_DIR/$BACKUP_FILE"  -C "$SOURCE_DIR" .




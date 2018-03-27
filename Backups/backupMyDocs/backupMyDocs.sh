#!/bin/bash

# Name    : backupMyDocs.sh 
# Author  : Snickasaurus
# Date    : 20180204
# Purpose : TAR /Users/$USER/Documents/MyDocs and move it to FreeNAS.

# Variables
currentUser=$(ls -l /dev/console | cut -d " " -f 4)
currentLogFile=/Users/"${currentUser}"/Library/Logs/_MyLogs/MyDocs-.log

# Functions
function currentTime(){
	date "+%Y%m%d-%H%M%S"
}

# Log Directory Check
if [ ! -d /Users/"$currentUser"/Library/Logs/_MyLogs ]
	then
	mkdir /Users/"$currentUser"/Library/Logs/_MyLogs
fi

# Logging
exec 3>&1 4>&2 
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>"$currentLogFile" 2>&1

# Prune old backups
find /Volumes/Backups/Mac/macmini1/MyDocs-*.tar -ctime +25 -print0 | xargs -0 rm
find /Users/"$currentUser"/Library/Logs/_MyLogs/MyDocs-*.log -ctime +25 -print0 | xargs -0 rm

# Stamp Log File - Starting Tar
echo "=====Starting @ "$(date "+%H:%M:%S  %Y/%m/%d")" ====="
echo " "
echo " "

# Backup MyDocs directory
cd /Volumes/Backups/Mac/macmini1 && /usr/bin/tar -cvf MyDocs-.tar --exclude=".DS_Store" -C /Users/"$currentUser"/Documents/MyDocs .

# Stamp Log File - Tar Complete
echo " "
echo " "
echo "=====Completed @ "$(date "+%H:%M:%S  %Y/%m/%d")" ====="

# Rename the log file and archive.
cd /Users/"$currentUser"/Library/Logs/_MyLogs && /bin/mv MyDocs-.log MyDocs-"$(currentTime)".log
cd /Volumes/Backups/Mac/macmini1 && /bin/mv MyDocs-.tar MyDocs-"$(currentTime)".tar

exit 0

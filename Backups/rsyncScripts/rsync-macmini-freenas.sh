#!/bin/bash

# Name    : rsync-macmini-freenas.sh 
# Author  : Snickasaurus
# Date    : 20180217
# Purpose : rSync "~/Dropbox/Scripts" to FreeNAS.

# Variables
currentUser=$(ls -l /dev/console | cut -d " " -f 4)
currentLogFile=/Users/"${currentUser}"/Library/Logs/_MyLogs/RsyncScriptsFreeNAS-.log
theSource="/Users/${currentUser}/Dropbox/Scripts/"
theDestination="/Volumes/Scripts/"

# Functions
function currentTime(){
	date "+%Y%m%d-%H%M%S"
}

# Log Directory Check
if [ ! -d /Users/"$currentUser"/Library/Logs/_MyLogs ]
	then
	mkdir /Users/"$currentUser"/Library/Logs/_MyLogs
fi

# Backup Directory Check
if [ ! -d ${theDestination} ]
	then
	mkdir ${theDestination}
fi

# Logging
exec 3>&1 4>&2 
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>"$currentLogFile" 2>&1

# Prune old backups
find /Users/"$currentUser"/Library/Logs/_MyLogs/RsyncScriptsFreeNAS-*.log -ctime +25 -print0 | xargs -0 rm

# Exclude
declare -a eList=(
	".DS_Store"
)


# Backup starting.
echo "========  Starting @ "$(date "+%H:%M:%S  %Y/%m/%d")" ====="
echo "===="
echo "=="

# Rsync
/usr/bin/rsync -avzEh --delete --stats --exclude="$eList" "$theSource" "$theDestination"

# Backup completed.
echo "=="
echo "===="
echo "========  Completed @ "$(date "+%H:%M:%S  %Y/%m/%d")" ====="

# Rename the log file.
cd /Users/"$currentUser"/Library/Logs/_MyLogs && /bin/mv RsyncScriptsFreeNAS-.log RsyncScriptsFreeNAS-"$(currentTime)".log

exit 0

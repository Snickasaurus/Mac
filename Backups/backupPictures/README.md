# Create a tar archive for my ~/Pictures directory

In your macOS user directory will be "Pictures". This script will simply tar that folder and copy it to my NAS.

My setup: macOS High Sierra (10.13.3) and FreeNAS 11-1-U2

What's happeneing in this script.

- Variables are set to get the current logged in user and mark what will be the log file.
- A function called "CurrentTime" is created.
- A check is run to make sure the log directory is present and if not then it's created.
- Logging is captured from stin stout and sterr.
- Using the 'find' command, old backups and log files are removed to make room.
- Stamping the log file to show the beginning of the script with time stamp.
- Change directory to the backup location and run the tar command.
- Stop the log file to show the backup is finished running.
- Rename the log file and backup archive using the 'currentTime' function.

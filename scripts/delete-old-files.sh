#!/bin/bash

# Delete old data files

# We delete files more "aggressively" if the storage space is full.
# If the available disk space is low, then delete more recent files, up to
# "x" minutes old. If there's plenty of disk space, then we can delete up to "y" days old.
# We can test this command using the --dry-run option.

# Options
# Check disk usage on remote file system
file_system="/"
# Delete data above this percentage disk usage
threshold=50
# Delete files older than x minutes
delete_older_than_minutes=30
# Delete files older than y days
delete_older_than_days=7
name="*.np"
remote_directory="/home/pi/beephotos"

# Get the disk usage
percentage=$(df "$file_system" --output='pcent' | grep --only-matching "[0-9]*")

# If the disk usage is above the threshold
if [[ "$percentage"  -gt "$threshold" ]]; then
  echo "Available disk space low, deleting files older than $delete_older_than_minutes minutes..."
  # Delete files older than x minutes
  # For the find command, we can test it by removing the -delete option.
  # find docs: https://manpages.ubuntu.com/manpages/xenial/man1/find.1.html
  # -mtime +n means greater than (-n means less than)
  find "$remote_directory" -mindepth 1 -mmin +$delete_older_than_minutes -type f -name "$name" -delete
else
  # Delete files older than x days
  # Use -mtime instead of -mmin argument.
  echo "Deleting files older than $delete_older_than_days days..."
  find "$remote_directory" -mindepth 1 -mtime +$delete_older_than_days -type f -name "$name" -delete
fi

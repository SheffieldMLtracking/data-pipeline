#!/bin/bash

# Options
# The directory on the remote machine
remote_directory="/home/pi/beephotos"
# The directory on this machine
local_directory="/mnt/san/shared/pml_group/Shared"
max_box_count=99
# Delete files older than n days
delete_older_than_days=28
name="*.np"

# Iterate over all boxes
# (It'll skip over any machines that it can't connect to because they don't exist or are offline.)
for i in $(seq 1 $max_box_count)
do
  # Specify the SSH configuration profile
  remote_host="raspberry$i"
  echo "$remote_host"

  # Run the data sync, and, *if successful*, also delete old files.
  # We can test this command using the --dry-run option.
  # rsync docs: https://manpages.ubuntu.com/manpages/focal/man1/rsync.1.html
  # The && operator means the sync must conclude before deletion happens.
  # For the find command, we can test it by removing the -delete option.
  # find docs: https://manpages.ubuntu.com/manpages/xenial/man1/find.1.html
  /usr/bin/rsync --archive --compress --update --verbose $remote_host:$remote_directory $local_directory && \
  /usr/bin/ssh $remote_host -t "find $remote_directory -mindepth 1 -mtime +$delete_older_than_days -type f -name "$name" -delete"
done

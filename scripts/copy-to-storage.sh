#!/bin/bash

# Options
# The directory on the remote machine
remote_directory="/home/pi/beephotos"
# The directory on this machine
local_directory="/mnt/san/shared/pml_group/Shared"
# Delete files older than n days
delete_older_than_days=7
name="*.np"
# Select target machines
min_rpi_number=1
max_rpi_number=99
raspberry_ids="$(seq $min_rpi_number $max_rpi_number)"

# Iterate over all boxes
# (It'll skip over any machines that it can't connect to because they don't exist or are offline.)
for i in $raspberry_ids
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
  /usr/bin/ssh $remote_host -t "find \"$remote_directory\" -mindepth 1 -mtime +$delete_older_than_days -type f -name \"$name\" -delete"
done

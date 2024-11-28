#!/bin/bash

# Move files from remote machines to local storage.

# Options
# The directory on the remote machine
remote_directory="${REMOTE_DIRECTORY:-/home/pi/beephotos}"
# The directory on this machine
local_directory="${LOCAL_DIRECTORY:-/mnt/san/shared/pml_group/Shared}"
# Select target machines
min_rpi_number="${MIN_RPI_NUMBER:-1}"
max_rpi_number="${MAX_RPI_NUMBER:-99}"
raspberry_ids="$(seq $min_rpi_number $max_rpi_number)"
host_prefix="${HOST_PREFIX:-raspberry}"
rsync_options="${RSYNC_OPTIONS:---remove-source-files --archive --compress --update --verbose}"

# Iterate over all boxes
# (It'll skip over any machines that it can't connect to because they don't exist or are offline.)
for i in $raspberry_ids
do
  # Specify the SSH configuration profile
  remote_host="$host_prefix$i"
  echo "$remote_host"

  # Move files
  # rsync docs: https://manpages.ubuntu.com/manpages/focal/man1/rsync.1.html
  # The source files will be deleted from the remote host after they are transferred.
  # If a file is modified during transfer, rsync will fail. That file will be transferred during the subsequent run.
  /usr/bin/rsync "$rsync_options" "$remote_host":"$remote_directory" "$local_directory"
done

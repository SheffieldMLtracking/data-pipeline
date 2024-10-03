#!/bin/bash

# Move files from remote machines to local storage.

# Options
# The directory on the remote machine
remote_directory="/home/pi/beephotos"
# The directory on this machine
local_directory="/mnt/san/shared/pml_group/Shared"
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

  # Move files
  # rsync docs: https://manpages.ubuntu.com/manpages/focal/man1/rsync.1.html
  /usr/bin/rsync --remove-source-files --archive --compress --update --verbose "$remote_host":"$remote_directory" "$local_directory"
done

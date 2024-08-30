#!/bin/bash

# Options
# The directory on the remote machine
source_dir="/home/pi/beephotos"
# The directory on this machine
local_dir="/mnt/san/shared/pml_group/Shared/beephotos"
max_box_count=99
# Delete files older than n days
delete_older_than_days=28
name="*.np"

# Iterate over all boxes
# (It'll skip over any machines that it can't connect to because they don't exist or are offline.)
for i in $(seq 1 $max_box_count)
do
  # Specify the SSH configuration profile
  target="raspberry$i"

  # Run the data sync, and, *if successful*, also delete old files
  # The && operator means the sync must conclude before deletion happens
  /usr/bin/rsync --archive --compress --update --verbose $target:$source_dir $local_dir && \
  /usr/bin/ssh $target -t "find $source_dir -mindepth 1 -mtime +$delete_older_than_days -type f -name "$name" -delete"
done

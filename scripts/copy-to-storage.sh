#!/usr/bin/env sh

# Options
# The directory on the remote machine
source_dir="/home/pi/beephotos"
# The directory on this machine
local_dir="/mnt/shared/pml_group/Shared/beephotos"
max_box_count=99

# Iterate over 99 possible boxes
for i in $(seq 1 $max_box_count)
do
  # Specify the SSH configuration profile
  target="raspberry$i"

  # Run the data sync
  /usr/bin/rsync --archive --compress --update --verbose $target:$source_dir $local_dir
done

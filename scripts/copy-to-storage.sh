#!/bin/bash

# Run the data sync, and, *if successful*, also delete old files.


# Options
# The directory on the remote machine
remote_directory="/home/pi/beephotos"
# The directory on this machine
local_directory="/mnt/san/shared/pml_group/Shared"
# Select target machines
min_rpi_number=1
max_rpi_number=99
raspberry_ids="$(seq $min_rpi_number $max_rpi_number)"
delete_script_path="/opt/data-pipeline/delete-old-files.sh"

# Iterate over all boxes
# (It'll skip over any machines that it can't connect to because they don't exist or are offline.)
for i in $raspberry_ids
do
  # Specify the SSH configuration profile
  remote_host="raspberry$i"
  echo "$remote_host"

  # Transfer data
  # rsync docs: https://manpages.ubuntu.com/manpages/focal/man1/rsync.1.html
  /usr/bin/rsync --archive --compress --update --verbose "$remote_host":"$remote_directory" "$local_directory"
  rsync_exit_code="$?"

  # Delete old data

  # Only proceed to this steps if the data sync was successful.
  if [[ "$rsync_exit_code" != 0 ]]; then
    echo "rsync error, skipping data deletion."
    continue
  else

    # Get disk usage proportion
    percentage="$(df $file_system --output='pcent' | grep --only-matching "[0-9]*")"
    echo "Disk usage $percentage%"

    # If the disk usage is above the threshold
    if [[ "$percentage" -gt "$threshold" ]]; then
      echo "Available disk space low! Deleting files older than $delete_older_than_minutes minutes";
      # Delete files older than x minutes
      # For the find command, we can test it by removing the -delete option.
      # find docs: https://manpages.ubuntu.com/manpages/xenial/man1/find.1.html
      # -mtime +n means greater than (-n means less than)
      find $remote_directory -mindepth 1 -mmin +$delete_older_than_minutes -type f -name \"$name\" -delete
    else
      echo "Disk space okay, deleting files older than $$delete_older_than_days days...";
      # Delete files older than x days
      find $remote_directory -mindepth 1 -mtime +$delete_older_than_days -type f -name \"$name\" -delete
    fi
  fi

  # Here documents, see https://tldp.org/LDP/abs/html/here-docs.html
  # EOF usage, see https://github.com/koalaman/shellcheck/wiki/SC2087

  /usr/bin/ssh "$remote_host" "bash -s" < $delete_script_path
done

#!/bin/bash

# Delete old data files

# We delete files more "aggressively" if the storage space is full.
# If the available disk space is low, then delete more recent files, up to
# "x" minutes old. If there's plenty of disk space, then we can delete up to "y" days old.
# We can test this command using the --dry-run option.

# Options
# Delete files older than n days
delete_older_than_days=7
name="*.np"
# Check disk usage on remote file system
file_system="/"
# Delete data above this percentage disk usage
threshold=50
# Delete files older than x minutes
delete_older_than_minutes=30

#!/bin/bash

# Run a script if the disk usage is above a
# threshold.
file_system="/"
# Percentage disk usage
threshold=50

if [ "$(df $file_system --output='pcent' | grep --only-matching "[0-9]*")" -gt $threshold ]
then
  echo "Full!"
else
  echo "Okay"
fi

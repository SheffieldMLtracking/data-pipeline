#!/bin/bash

# Run a script if the disk usage is above a
# threshold.
file_system="/"
# Percentage disk usage
threshold=50

# Get disk usage
percentage=$(df $file_system --output='pcent' | grep --only-matching "[0-9]*")

if [[ "$percentage" -gt "$threshold" ]]; then
  echo "Full!"
else
  echo "Okay"
fi

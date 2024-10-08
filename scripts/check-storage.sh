#!/bin/bash

# Check storage on remote machines

# Define target machine numbers
raspberry_ids=$(seq 30 35)

# Iterate over target machines
for i in $raspberry_ids
do
  host="raspberry$i"
  echo "$host"
  
  # Display disk usage
  ssh "$host" -t "du /home/pi/beephotos --human-readable --summarize && df -hT /"
done

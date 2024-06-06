#!/bin/bash

# Script configuration
HOST="ohiobeeproject.shef.ac.uk"
PORT=22
USERNAME="your_username"
PASSWORD="your_password"
LOCAL_DIR="/path/to/local/data"
REMOTE_DIR="/path/to/remote/data"

lftp << EOF

# Connect to the SFTP server
open sftp://${USERNAME}:${PASSWORD}@${HOST}:${PORT}

# Mirror the local directory to the remote server (recursive)
mirror -R --verbose $LOCAL_DIR $REMOTE_DIR

# Close the connection
bye

EOF

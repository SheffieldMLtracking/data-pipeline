#!/bin/bash

# Script configuration
host="ohiobeeproject.shef.ac.uk"
port=22
username="service_account_username"
local_dir="/path/to/local/data"
key_file="/path/to/key_file.key"
remote_dir="/path/to/remote/data"

# LFTP script
# LFTP manual:
# https://lftp.yar.ru/lftp-man.html
lftp << EOF
# Specify the authentication key
set sftp:connect-program "ssh -ax -i $key_file"

# Connect to the SFTP server
open sftp://${username}:@${host}:${port}

# Mirror the local directory to the remote server (recursive)
# Reverse mirror means put files
mirror --reverse --verbose $local_dir $remote_dir

# Close the connection
bye

EOF

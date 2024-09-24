#!/bin/bash
set -e

# Install this data pipeline
# Usage: sudo sh install.sh

# Install dependencies
apt install --yes -qqq rsync

# Install service files and scripts
cp --verbose ./scripts/systemd/*.service /etc/systemd/system/
cp --verbose ./scripts/systemd/*.timer /etc/systemd/system/
# Reload the systemd manager configuration. See: https://manpages.ubuntu.com/manpages/xenial/en/man1/systemctl.1.html
systemctl daemon-reload
mkdir --parents /opt/data-pipeline
cp --verbose ./scripts/copy-to-storage.sh /opt/data-pipeline/copy-to-storage.sh

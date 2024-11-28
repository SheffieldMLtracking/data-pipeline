#!/bin/bash
set -e

# Install this data pipeline
# Usage: sudo sh install.sh

# Install dependencies
apt install --yes -qqq rsync

# Install services
cp --recursive --verbose ./systemd/* /etc/systemd/system/
# Reload the systemd manager configuration.
# See: https://manpages.ubuntu.com/manpages/xenial/en/man1/systemctl.1.html
systemctl daemon-reload

# Install scripts
mkdir --parents /opt/data-pipeline
cp --verbose ./scripts/*.sh /opt/data-pipeline/

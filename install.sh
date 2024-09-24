#!/bin/bash
set -e

# Install this data pipeline
# Usage: sudo sh install.sh

# Install dependencies
apt install --yes -qqq rsync

# Install service files and scripts
cp --verbose ./scripts/systemd/*.service /etc/systemd/system/
cp --verbose ./scripts/systemd/*.timer /etc/systemd/system/
mkdir --parents /opt/data-pipeline
cp ./scripts/copy-to-storage.sh /opt/data-pipeline/copy-to-storage.sh

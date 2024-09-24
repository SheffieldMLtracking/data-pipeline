#!/bin/bash
set -e

# Install dependencies
apt install --yes -qqq rsync

# Install service files and scripts
sudo cp --verbose ./scripts/systemd/*.service /etc/systemd/system/
sudo cp --verbose ./scripts/systemd/*.timer /etc/systemd/system/
sudo mkdir --parents /opt/data-pipeline
sudo cp ./scripts/copy-to-storage.sh /opt/data-pipeline/copy-to-storage.sh

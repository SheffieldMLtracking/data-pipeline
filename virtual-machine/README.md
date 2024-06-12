# Virtual machine

These scripts should run on the virtual machine that hosts the SFTP server.

# Installation

```bash
# Install dependencies
sudo apt install rsync

# Install systemd units
# TODO
sudo cp --verbose ./virtual-machine/systemd/* /etc/systemd/something

# Activate the service
sudo systemctl enable copy-to-storage
```

# Usage

[systemctl](https://www.freedesktop.org/software/systemd/man/latest/systemctl.html)

```bash
sudo systemctl start copy-to-storage
sudo systemctl stop copy-to-storage
```

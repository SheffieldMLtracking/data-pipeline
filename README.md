# Ohio bee tracker data pipeline

This repository contains scripts to implement the automatic transfer of data from the Raspberry Pi machines deployed in Ohio to the University of Sheffield infrastructure.

See [issue 20](https://github.com/SheffieldMLtracking/BBSRC_ohio/issues/20)

The repository contains the following directories:

- [raspberry-pi](./raspberry-pi) contains the scripts that will run on the bee tracker boxes that send the data
- [virtual-machine](./virtual-machine) contains the scripts that will run on the virtual machine that receives the data

# Installation

Please follow the installation steps detailed in the README files in each directory in this repository.

# Usage

The services defined in this repository are `systemd` units that are controlled using [`systemctl`](https://www.freedesktop.org/software/systemd/man/latest/systemctl.html).

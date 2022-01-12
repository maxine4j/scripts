# scripts

This repository contains a collection of useful scripts that fix issues, restore functionality, and add new utility to unix-like operating systems. 

Some are designed to be run at login and others can should sourced by your shell's rc script.

## Installation

### Run Commands

1. Please clone this repository to `~/scripts` and run `echo "source ~/scripts/rc/rc.sh" >> ~/.zshrc`

### OS Specific Startup Scripts

These scripts are intended to be run on startup and will need to be installed in your desktop environemnt.

#### Mac

1. Open System Preferences > Users & Groups > Login Items
2. Add `scripts/startup/macos.sh as a new Login Item


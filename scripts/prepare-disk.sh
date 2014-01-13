#!/bin/sh

# Create a Linux partion that takes up the whole disk.
# 'sudo' has already been enabled by boot2docker.
echo "
n  # new partition
p  # primary
1  # first partion


w  # write partition table and quit
" | sudo fdisk /dev/sda

# Format /dev/sda1 as ext4
sudo mkfs.ext4 /dev/sda1

# Make sure it's mountable
sudo mkdir /mnt/sda1 
sudo mount /dev/sda1 /mnt/sda1
sudo mount | grep -q /dev/sda1 || exit 8

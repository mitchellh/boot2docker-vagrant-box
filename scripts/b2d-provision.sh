#!/bin/sh

set -e
set -x

MOUNT_POINT=/mnt/data
B2D_PERSISTENT_DIR=${MOUNT_POINT}/var/lib/boot2docker
TMP_USERDATA_DIR=/tmp/userdata
HDD_DEV=/dev/sda
B2D_DATA_DEV="${HDD_DEV}2"

# Format globally $HDD_DEV for cleaning eventually old partition table
echo "== Dumping boot2docker.iso to ${HDD_DEV} :"
dd if=/tmp/boot2docker-vagrant.iso of=${HDD_DEV}

# Creating one partition and formating to ext4
# See https://github.com/boot2docker/boot2docker/issues/531#issuecomment-61740859
echo "== Creating a second partition"
echo "n
p
2


w
"| /sbin/fdisk ${HDD_DEV}
echo "== Formating the partition in ext4 with the boot2docker-data label"
/sbin/mkfs.ext4 -L boot2docker-data ${B2D_DATA_DEV}

echo "p" | /sbin/fdisk ${HDD_DEV}

# Mounting the freshly formatted volume to copy persisted content
echo "== Mounting new partition to customize"
mkdir -p ${MOUNT_POINT}
mount ${HDD_DEV}2 ${MOUNT_POINT}

echo "== Inserting vagrant key in the userdata.tar which should be deployed when boot2docker boot"
mkdir -p ${B2D_PERSISTENT_DIR} ${TMP_USERDATA_DIR}/.ssh
cat <<KEY >${TMP_USERDATA_DIR}/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
KEY
chmod 0600 ${TMP_USERDATA_DIR}/.ssh/authorized_keys

echo "== Compress and copy userdata"
cd ${TMP_USERDATA_DIR}
tar cf ${B2D_PERSISTENT_DIR}/userdata.tar ./.ssh

echo "== Customize docker daemon"
cat <<EOF >${B2D_PERSISTENT_DIR}/profile
# Insert custom Docker daemon settings here

EOF

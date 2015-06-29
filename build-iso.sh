#!/bin/bash
#
# This script takes a boot2docker.iso and re-processes it to be usable
# by Vagrant.
#
set -e
set -x

B2D_URL="https://github.com/boot2docker/boot2docker/releases/download/v1.7.0/boot2docker.iso"
RSYNC_URL="https://github.com/cameronbrunner/tinycorelinux-extensions/releases/download/rsync-0.0.1/rsync.tcz"
echo "Building with EXTRA_ARGS: $EXTRA_ARGS"

apt-get -y update
apt-get install -y genisoimage

#--------------------------------------------------------------------
# B2D
#--------------------------------------------------------------------
# Download boot2docker
wget -O b2d.iso ${B2D_URL}
if [ ! -f /vagrant/rsync.tcz ];then
wget -O /vagrant/rsync.tcz ${RSYNC_URL}
fi

# Mount it up
rm -rf /tmp/boot
mkdir -p /mnt/tmp
mount b2d.iso /mnt/tmp -o loop,ro
cp -a /mnt/tmp/boot /tmp
mv /tmp/boot/initrd.img /tmp
umount /mnt/tmp

# Extract the core filesystem
EXTRACT_DIR="/tmp/extract"
rm -rf ${EXTRACT_DIR}
mkdir -p ${EXTRACT_DIR}
pushd ${EXTRACT_DIR}
lzma -dc /tmp/initrd.img | cpio -i -H newc -d
popd

#--------------------------------------------------------------------
# Customization
#--------------------------------------------------------------------
# Script to add in public key
cat <<EOF > ${EXTRACT_DIR}/etc/rc.d/vagrant
mkdir -p /home/docker/.ssh
chmod 0700 /home/docker/.ssh

cat <<KEY >/home/docker/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
KEY
chmod 0600 /home/docker/.ssh/authorized_keys

chown -R docker:staff /home/docker/.ssh
EOF
chmod +x ${EXTRACT_DIR}/etc/rc.d/vagrant

# Configure boot to add public key
echo "/etc/rc.d/vagrant" >> ${EXTRACT_DIR}/opt/bootsync.sh

# Disable TLS
cat <<EOF > ${EXTRACT_DIR}/etc/rc.d/docker-profile
mkdir -p /var/lib/boot2docker
echo 'export DOCKER_TLS=no' > /var/lib/boot2docker/profile
echo 'export EXTRA_ARGS="$EXTRA_ARGS"' >> /var/lib/boot2docker/profile
/etc/init.d/docker stop
/etc/init.d/docker start
EOF
chmod +x ${EXTRACT_DIR}/etc/rc.d/docker-profile
echo "/etc/rc.d/docker-profile" >> ${EXTRACT_DIR}/opt/bootsync.sh

# Script install 64 bit rsync package
cp /vagrant/rsync.tcz ${EXTRACT_DIR}/opt
echo "su - docker -c 'tce-load -i /opt/rsync.tcz'" > ${EXTRACT_DIR}/etc/rc.d/rsync
chmod +x ${EXTRACT_DIR}/etc/rc.d/rsync
echo "/etc/rc.d/rsync" >> ${EXTRACT_DIR}/opt/bootsync.sh

#--------------------------------------------------------------------
# Package
#--------------------------------------------------------------------
# Make the initrd.img image...
pushd ${EXTRACT_DIR}
find | cpio -o -H newc | xz -9 --format=lzma > /tmp/initrd.img
popd

# Make the ISO
pushd /tmp
mv initrd.img boot
mkdir newiso
mv boot newiso
popd
mkisofs -l -J -R -V b2d-vagrant -no-emul-boot -boot-load-size 4 \
 -boot-info-table -b boot/isolinux/isolinux.bin \
 -c boot/isolinux/boot.cat -o boot2docker-vagrant.iso /tmp/newiso
rm -rf /tmp/newiso

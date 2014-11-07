FROM boot2docker/boot2docker:latest
MAINTAINER damien.duportal@gmail.com

RUN rm -f boot2docker.iso

####### Vagrant customisation

# This script will :wq
COPY vagrant-rc-script $ROOTFS/etc/rc.d/vagrant
RUN chmod +x $ROOTFS/etc/rc.d/vagrant

# We need to  execute rc script when booting
RUN echo "/etc/rc.d/vagrant" >> $ROOTFS/opt/bootsync.sh

#### Build the iso from $ROOTFS
RUN /make_iso.sh
CMD ["cat", "boot2docker.iso"]


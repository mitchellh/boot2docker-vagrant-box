FROM boot2docker/boot2docker-rootfs
MAINTAINER damien.duportal@gmail.com

# Getting the latest Docker
RUN curl -L -o $ROOTFS/usr/local/bin/docker https://get.docker.io/builds/Linux/x86_64/docker-latest && \
    chmod +x $ROOTFS/usr/local/bin/docker

# Install OpenSSH Daemon for vagrant build
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:vagrant' |chpasswd

# Specific Vagrant things
ADD vagrant $ROOTFS/etc/rc.d/vagrant
RUN chmod a+x $ROOTFS/etc/rc.d/vagrant
RUN echo "/etc/rc.d/vagrant" >> $ROOTFS/bootsync.sh

# VBox additions insertion
RUN apt-get install -y p7zip-full

RUN mkdir -p /vboxguest && \
    cd /vboxguest && \
    curl -L -o vboxguest.iso http://download.virtualbox.org/virtualbox/4.3.8/VBoxGuestAdditions_4.3.8.iso && \
    7z x vboxguest.iso -ir'!VBoxLinuxAdditions.run' && \
    sh VBoxLinuxAdditions.run --noexec --target . && \
    mkdir x86 && cd x86 && tar xvjf ../VBoxGuestAdditions-x86.tar.bz2 && cd .. && \
    mkdir amd64 && cd amd64 && tar xvjf ../VBoxGuestAdditions-amd64.tar.bz2 && cd .. && \
    cd amd64/src/vboxguest-4.3.8 && KERN_DIR=/linux-kernel/ make && cd ../../.. && \
    cp amd64/src/vboxguest-4.3.8/*.ko $ROOTFS/lib/modules/$KERNEL_VERSION-tinycore64 && \
    mkdir -p $ROOTFS/sbin && cp x86/lib/VBoxGuestAdditions/mount.vboxsf $ROOTFS/sbin/

RUN depmod -a -b $ROOTFS $KERNEL_VERSION-tinycore64

RUN echo "modprobe vboxsf" >> $ROOTFS/bootsync.sh

# Build the iso
RUN /make_iso.sh

# Launching the VM
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]


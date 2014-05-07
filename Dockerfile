FROM boot2docker/boot2docker-rootfs

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:vagrant' |chpasswd

ADD vagrant $ROOTFS/etc/rc.d/vagrant
RUN chmod a+x $ROOTFS/etc/rc.d/vagrant
RUN echo "/etc/rc.d/vagrant" >> $ROOTFS/bootsync.sh

RUN /make_iso.sh

EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]


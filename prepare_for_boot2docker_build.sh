#!/bin/bash

# Some deps
sudo apt-get update
sudo apt-get install -y wget git

# Getting boot2docker, last master version
rm -rf /tmp/boot2docker
git clone https://github.com/boot2docker/boot2docker /tmp/boot2docker

# Adding python dep to tcz deps of b2d
sed -i 's#ntpclient#ntpclient python#g' /tmp/boot2docker/rootfs/Dockerfile

# Wana get rid of proxy problems and other bad SSL chain cert ?
sed -i 's#ftp://#http://#g' /tmp/boot2docker/rootfs/Dockerfile
sed -i 's#git://#http://#g' /tmp/boot2docker/rootfs/Dockerfile
sed -i 's#https://#http://#g' /tmp/boot2docker/rootfs/Dockerfile

# Getting base image
sudo docker pull steeve/boot2docker-base

# Building b2d
cd /tmp/boot2docker
sudo docker build -t boot2docker --rm rootfs/
sudo docker rm build-boot2docker
sudo docker run --privileged -name build-boot2docker boot2docker
sudo docker cp build-boot2docker:/boot2docker.iso .


# Preparing boot2docker from mitchellh (we deactivate temporarly the wget to boot2docker iso)
sed -i 's/B2D_URL=/#B2D_URL=/g' /vagrant/build-iso.sh
sed -i 's/wget -O b2d.iso/#wget -O b2d.iso/g' /vagrant/build-iso.sh

cp /tmp/boot2docker/boot2docker.iso /vagrant/b2d.iso

sudo bash /vagrant/build-iso.sh

sed -i 's/#B2D_URL=/B2D_URL=/g' /vagrant/build-iso.sh
sed -i 's/#wget -O b2d.iso/wget -O b2d.iso/g' /vagrant/build-iso.sh


#!/bin/bash

# Build a custom b2d with vbox extensions
if [[ ! -f boot2docker-vagrant.iso ]]; then
	vagrant up 

	# If we provide a string, i assume this the tag to the boot2docker githu reporsitory
	if [[ -n "$1" ]]; then
		rm -rf boot2docker
		git clone https://github.com/boot2docker/boot2docker
		cd boot2docker
		git checkout "$1" || exit 1
		cd -

		# Build the vanilla boot2docker image
		vagrant ssh -c "docker build -t boot2docker/boot2docker /vagrant/boot2docker"

	fi

	# Build the custom boot2docker from vanilla image
	vagrant ssh -c "docker build -t my-b2d /vagrant/ && docker run --rm my-b2d > /vagrant/boot2docker-vagrant.iso"

	vagrant halt
fi


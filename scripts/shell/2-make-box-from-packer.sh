#!/bin/bash

if [[ -f boot2docker-vagrant.iso ]]; then
	# Simple packer build, vbox only
	packer build template.json
fi



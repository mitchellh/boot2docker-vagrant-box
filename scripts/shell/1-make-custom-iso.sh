#!/bin/bash

# Build a custom b2d with vbox extensions
if [[ ! -f b2d.iso ]]; then
	vagrant up #The vagrant up will build the iso and copy it locally
	vagrant destroy -f
fi


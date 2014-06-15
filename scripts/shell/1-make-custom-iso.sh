#!/bin/bash

# Build a custom b2d with vbox extensions
cd b2d-vbox
vagrant up #The vagrant up will build the iso and copy it locally
vagrant destroy -f
cd -

# Standard mitchellh build injecting vagrant things into the b2d.iso
vagrant up
vagrant ssh -c 'cd /vagrant && sudo ./build-iso.sh'
vagrant destroy -f

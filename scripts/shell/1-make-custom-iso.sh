#!/bin/bash

#The vagrant up will build the iso and copy it locally
vagrant up --provider=docker

vagrant destroy -f



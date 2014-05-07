#!/bin/bash

# Simple packer build, vbox only
packer build -only=virtualbox-iso template.json


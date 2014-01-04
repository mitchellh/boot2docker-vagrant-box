# boot2docker Vagrant Box

This repository contains the scripts necessary to create a Vagrant-compatible
[boot2docker](https://github.com/steeve/boot2docker) box. If you work solely
with Docker, this box lets you keep your Vagrant workflow and work in the
most minimal Docker environment possible.

## Usage

If you just want to use the box, then download the latest box from
the [releases page](#) and `vagrant up` as usual!

If you want to build a custom b2d box, then this repository contains
the sources that allow you to do it in minutes.

## Building the Box

To build the box, first install the following prerequisites:

  * [Packer](http://www.packer.io) (at least version 0.5.1)
  * [VirtualBox](http://www.virtualbox.org)

Then, just run `make`. The resulting box will be named "boot2docker.box".
The entire process to make the box takes about 20 seconds.

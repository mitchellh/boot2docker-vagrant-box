# boot2docker Vagrant Box

This repository contains the scripts necessary to create a Vagrant-compatible
[boot2docker](https://github.com/steeve/boot2docker) box. If you work solely
with Docker, this box lets you keep your Vagrant workflow and work in the
most minimal Docker environment possible.

## Usage

If you just want to use the box, then download the latest box from
the [releases page](https://github.com/mitchellh/boot2docker-vagrant-box/releases)
and `vagrant up` as usual! Or, if you don't want to leave your terminal:

    $ vagrant init boot2docker https://github.com/mitchellh/boot2docker-vagrant-box/releases/download/v0.3.0/boot2docker.box
    $ vagrant up

![Vagrant Up Boot2Docker](https://raw.github.com/mitchellh/boot2docker-vagrant-box/master/readme_image.gif)

## Building the Box

If you want to recreate the box, rather than using the binary, then
you can use the Packer template and sources within this repository to
do it in seconds.

To build the box, first install the following prerequisites:

  * [Packer](http://www.packer.io) (at least version 0.5.1)
  * [VirtualBox](http://www.virtualbox.org) or [VMware Fusion](http://www.vmware.com/fusion)

Then, just run `make virtualbox` or `make vmware`. The resulting box will
be built into `boxes/{virtualbox,vmware}` and named "boot2docker.box".
The entire process to make the box takes about 30 seconds.

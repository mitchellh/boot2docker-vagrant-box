
## Not released (dduportal-1.6.2)
- Moving boot2docker to 1.6.2 : https://github.com/boot2docker/boot2docker/releases/tag/v1.6.2

## 13/05/2015 (dduportal-1.6.1)
- Moving boot2docker to 1.6.1 : https://github.com/boot2docker/boot2docker/releases/tag/v1.6.1
- GH-10 : Making NFS working, environment variable powered, documentation added
- Corrections around the Makefile for building yourself

## 04/05/2015 (dduportal-1.6.0)
- Moving boot2docker to 1.6.0 : https://github.com/boot2docker/boot2docker/releases/tag/v1.6.0

## 15/02/2015 (v1.5.0)
- GH-6 : Adding a private id to the default private network in order to permit bypass at user level
- Moving to [docker v1.5.0](https://github.com/docker/docker/blob/master/CHANGELOG.md#150-2015-02-10) + [boot2docker v1.5.0](https://github.com/boot2docker/boot2docker/releases/tag/v1.5.0) 
- Support of rsync synced folder (rsync is installed in the box)
- Removing the box-embedded iso (Is now dumped to the first partition of the HDD)
- Adding a set of integration tests usings bats for testing the box with the vagrant provider 

## 13/01/2015 (v1.4.1-2)
- GH-5 : NFS support for synced folder
- GH-5 : bootlocalh.sh is now working (from the vagrant synced folder)
- GH-5 : Vagrant 1.7 support : Disabling the new behaviour with ssh keys
- Adding a private network in order to ease NFS synced folder and access to VM services
- Writing some docs in order to use this VM as a remote daemon

## 17/12/2014 (v1.4.1)
- Moving to boot2docker 1.4.1 (and Docker 1.4.1)

## 25/11/2014 (v1.3.2)
- Moving to boot2docker 1.3.2 and Docker 1.3.2 (security issues)

## 07/11/2014 (v1.3.1)
- Moving to boot2docker 1.3.1 (docker 1.3.1)
- Adding SSL docker's daemon port NAT to 2376
- NATed ports are now auto-moved when conflicting
- Packer 0.7 compatibility
- When docker-building, AUFS limit is now 128 layers instead of 42
- Packer-only new build process, from the vanilla boot2docker iso, checksumed
- bootlocal.sh can be used from /vagrant mount (alongside the Vagrantfile)

## 13/07/2014 (v1.1.1)
- Moving to boot2docker 1.1.1 (and Docker 1.1.1 by transitivity)
- Persisting the b2d dependency into the make.sh script for easying future updates and trusting
- Moving the default RAM of the VM to 2Gb

## 05/07/2014 (v1.1.0)
- Moving to docker v1.1.0
- Moving to boot2docker v1.1.0
- Adding some error handling when building from shell

## 22/06/2014 (v1.0.1)
- Moving to docker and b2d 1.0.1

## 19/06/2014 (v1.0.0)
- Building b2d-vbox and b2d vagrant custom in one Dockerfile instead of Docker + vagrant + ubuntu
- Adding possibility to build boot2docker vanilla image from official github repo instead of pulling from Docker index
- Move to b2d and docker 1.0.0 (bash make.sh v1.0.0)

## 15/06/2014 (v0.5.0)
- Moving to the new IANA Docker port 2375, and let vagrant auto corrects when collision
- Moving to boot2docker and Docker 1.0.0 
- Using a custom Vagrantfile for building a b2d iso with vbox addition
- Re-using temporarly mitchellh vagrantfile + build-iso workflow for "vagranti-zing" the b2d.iso
- Updating build scripts (Unix/Windows) with packer building all types

## 08/05/2014 (v0.4.0)
- Adding auto Docker update
- Moving to Docker 0.11.1

## 07/05/2014 (v0.3.0)
- Adding linux build chain and bats tests
- Moving to official boot2docker build system
- Integrate boot2docker build into a Vagrant Docker provider
- Vboxsf build into ISO (auto) [4.3.8]

## 23/04/2014 (v0.2.0)
- Adding custom_profile mangement
- Adding Windows build chain
- Adding docker and vagrant BATS tests, Windows only

## 21/04/2014 (v0.1.0)

- Fetching latest version from mitchellh offical repository (results in using a vagrant cloud baebox with no docker)
- Updating b2d to experimental build with vboxsf inside (https://github.com/boot2docker/boot2docker/issues/282)
- Updating build-iso.sh to add a /etc/rc.d script for loading vboxsf module at boot.
- Updating basebox's vagrantfile template to enable /vagrant share
- Updating basebox's vagrantfile template to aut correct docker's TCP port when launching multiple VMs

## 03/03/2014

- Using misheska's ubuntu basebox for running docker easily.
- Attempts to install fig from orchardups.

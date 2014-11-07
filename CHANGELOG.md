
## 07/11/2014 (v1.3.1)
- Moving to boot2docker 1.3.1 (docker 1.3.1)
- Adding SSL docker's daemon port NAT to 2376
- NATed ports are now auto-moved when conflicting
- Packer 0.7 compatibility
- When docker-building, AUFS limit is now 128 layers instead of 42
- Packer-only new build process, from the vanilla boot2docker iso, checksumed

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

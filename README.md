# What will you find here ?

This repository is used to build this vagrant basebox : https://vagrantcloud.com/dduportal/boot2docker
- We use boot2docker as vanilla as possible (using official Docker index or building it from boot2docker official github repo)
- We want to share folders with virtualbox shared folder in vagrant. This is not the best method but usefull anyway.
- We want the basebox build process to be as ligthweight as possible.

> See the CHANGELOG.md for history.

# Building the basebox

## Quick build :
(simple, is'nt it ?)

<<<<<<< HEAD
### On *nix :
```
bash make.sh (<Github Tag/Changeset> if you want to build all from source)
```
=======
If you want the actual box file, you can download it from the
[releases page](https://github.com/mitchellh/boot2docker-vagrant-box/releases).

On OS X, to use the docker client, follow the directions here:
http://docs.docker.io/installation/mac/#docker-os-x-client (you'll need to
export `DOCKER_HOST`). You should then be able to to run `docker version` from
the host.

![Vagrant Up Boot2Docker](https://raw.github.com/mitchellh/boot2docker-vagrant-box/master/readme_image.gif)

## Building the Box
>>>>>>> new-master

### On Windows (Partial support, help needed, don't hesitate to pull request!) :
```
make.bat
```

## Detailed build :

<<<<<<< HEAD
- First, we'll build the boot2docker iso with some customisations inside thru docker and a Dockerfile. It can take advantages of Docker trusted builds (https://github.com/boot2docker/boot2docker/blob/master/doc/BUILD.md) of boot2docker or build the original image from boot2docker github repo if you provide a git ref. The Dockerfile included will install vbox additions and vagrant stuff directly inside.
=======
  * [Packer](http://www.packer.io) (at least version 0.5.1)
  * [VirtualBox](http://www.virtualbox.org) (at least version 4.3), VMware, or Parallels
  * [Vagrant](http://www.vagrantup.com)
>>>>>>> new-master

- Second, we'll use this custom ISO to build a vagrant basebox, using packer and mitchellh's packer template (https://github.com/mitchellh/boot2docker-vagrant-box).

- Third, we'll run a set of tests for validating the content of the basebox : guarantee stability over updates.

<<<<<<< HEAD
=======
You can restrict only VirtualBox, VMware, or Parallels by specifying the `-only` flag
to Packer.
>>>>>>> new-master

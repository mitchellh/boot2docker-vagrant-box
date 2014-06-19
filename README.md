# What will you find here ?

This repository is used to build this vagrant basebox : https://vagrantcloud.com/dduportal/boot2docker
- We use boot2docker as vanilla as possible (using official Docker index or building it from boot2docker official github repo)
- We want to share folders with virtualbox shared folder in vagrant. This is not the best method but usefull anyway.
- We want the basebox build process to be as ligthweight as possible.

> See the CHANGELOG.md for history.

# Building the basebox

## Quick build :
(simple, is'nt it ?)

### On *nix :
```
bash make.sh (<Github Tag/Changeset> if you want to build all from source)
```

### On Windows (Partial support, help needed, don't hesitate tio pull request if you're ready to bat script !) :
```
make.bat
```

## Detailed build :

- First, we'll build the boot2docker iso with some customisations inside thru docker and a Dockerfile. It can take advantages of Docker trusted builds (https://github.com/boot2docker/boot2docker/blob/master/doc/BUILD.md) of boot2docker or build the original image from boot2docker github repo if you provide a git ref. The Dockerfile included will install vbox additions and vagrant stuff directly inside.

- Second, we'll use this custom ISO to build a vagrant basebox, using packer and mitchellh's packer template (https://github.com/mitchellh/boot2docker-vagrant-box).

- Third, we'll run a set of tests for validating the content of the basebox : guarantee stability over updates.


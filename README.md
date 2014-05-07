# What will you find here ?

My goal is to run boot2docker as a dev environment into vagrant with these constraints :
- Vagrant is running on Windows 7/8 x64 with virtualbox provider
- We want to share things already existing in the original host FS.
- We can run into a corporate env, with an HTTP proxy
- This repository is used to generate the basebox on vagrant cloud : https://vagrantcloud.com/dduportal/boot2docker.

> See the CHANGELOG.md for history.

# Building the basebox

## Quick build :
(simple, is'nt it ?)

### On *nix :
```
bash make.sh
```

### On *nix :
```
make.bat
```

## Detailled build :

- First, we'll build the boot2docker iso thru docker and a Dockerfile, taking advantages of trusted builds and extensive build provided by boot2docker guys (https://github.com/boot2docker/boot2docker/blob/master/doc/BUILD.md). We're using docker with the brand new Vagrant Docker provider.

- Second, we'll use this custom ISO to build a vagrant basebox, using packer.

- Third, we'll run a set of tests for validating the content of the basebox : guarantee stability over updates.


## Done :
- Using virtual box shared folder (using https://github.com/boot2docker/boot2docker/issues/282) for working by default with vagrant
- Custom profile : if you have a file "custom_profile.sh" at the root, it will be injected on your b2d box (example : configuring corporate HTTP proxy on interactive shell AND docker)
- A full Windows bat script chain for quickly build and launching the VM
- Bats tests suites for docker and vagrant, inside the VM (Windows only)
- Build chain for linux
- Running bats tests on linux
- Use Boot2docker official build


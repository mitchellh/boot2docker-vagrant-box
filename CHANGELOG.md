## 23/04/2014
- Adding custom_profile mangement
- Adding Windows build chain

## 21/04/2014

- Fetching latest version from mitchellh offical repository (results in using a vagrant cloud baebox with no docker)
- Updating b2d to experimental build with vboxsf inside (https://github.com/boot2docker/boot2docker/issues/282)
- Updating build-iso.sh to add a /etc/rc.d script for loading vboxsf module at boot.
- Updating basebox's vagrantfile template to enable /vagrant share
- Updating basebox's vagrantfile template to aut correct docker's TCP port when launching multiple VMs

## 03/03/2014

- Using misheska's ubuntu basebox for running docker easily.
- Attempts to install fig from orchardups.
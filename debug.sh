#A debugging workflow for testing the built vagrant image
vagrant destroy
vagrant box remove boot2docker
rm Vagrantfile
vagrant init boot2docker boot2docker.box
vagrant up --debug
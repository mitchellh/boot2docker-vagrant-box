build: boot2docker-vagrant.iso
	time (packer build -parallel=false template.json)

prepare: clean boot2docker-vagrant.iso

boot2docker_virtualbox.box: boot2docker-vagrant.iso
	packer build -only=virtualbox-iso template.json

boot2docker-vagrant.iso: build-iso.sh
	vagrant up
	vagrant ssh -c 'cd /vagrant && sudo ./build-iso.sh'
	vagrant destroy --force

clean:
	rm -rf *.iso *.box

.PHONY: clean prepare build

build: boot2docker-vagrant.iso
	time (packer build -parallel=false template.json)

prepare: clean boot2docker-vagrant.iso

boot2docker-vagrant.iso: build-iso.sh
	vagrant up
	vagrant ssh -c "cd /vagrant && sudo /bin/bash -c \"EXTRA_ARGS='${EXTRA_ARGS}' ./build-iso.sh\""
	vagrant destroy --force

clean:
	rm -rf *.iso *.box

.PHONY: clean prepare build

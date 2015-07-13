build: boot2docker-vagrant.iso
	time (packer build -parallel=false -only vmware-iso  template.json)

prepare: clean boot2docker-vagrant.iso

boot2docker-vagrant.iso:
	vagrant up
	vagrant ssh -c 'cd /vagrant && sudo ./build-iso.sh'
	vagrant destroy --force

clean:
	#rm -rf *.iso *.box
	rm -rf .vagrant
	rm -rf packer_cache


.PHONY: clean prepare build

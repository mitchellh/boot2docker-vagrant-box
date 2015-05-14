BOOT2DOCKER_VERSION = 1.6.1

build: boot2docker.iso
	time (packer build -parallel=false template.json)

prepare: clean boot2docker.iso

boot2docker.iso:
	curl -L -o boot2docker.iso https://github.com/boot2docker/boot2docker/releases/download/v$(BOOT2DOCKER_VERSION)/boot2docker.iso

test: test-virtualbox

test-virtualbox: clean-test-virtualbox
	@cd tests/virtualbox; bats --tap *.bats

clean: clean-build clean-test

clean-build:
	rm -rf *.iso *.box

clean-test-virtualbox:
	@cd tests/virtualbox;vagrant destroy -f
	rm -rf tests/*/Vagrantfile tests/*/.vagrant

.PHONY: clean prepare build test test-virtualbox

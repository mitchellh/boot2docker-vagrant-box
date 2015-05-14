BOOT2DOCKER_VERSION = 1.6.1

all: clean build test

build: boot2docker.iso
	time (packer build -parallel=false template.json)

boot2docker.iso:
	curl -L -o boot2docker.iso https://github.com/boot2docker/boot2docker/releases/download/v$(BOOT2DOCKER_VERSION)/boot2docker.iso

test:
	@cd tests/virtualbox; bats --tap *.bats

clean:
	rm -rf *.iso *.box

.PHONY: clean build test all

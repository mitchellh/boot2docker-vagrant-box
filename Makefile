build: boot2docker.iso
	time (packer build -parallel=false template.json)

prepare: clean boot2docker.iso

boot2docker.iso:
	curl -L -o boot2docker.iso https://github.com/boot2docker/boot2docker/releases/download/v1.6.0/boot2docker.iso

test: test-virtualbox

test-virtualbox:
	@cd tests/virtualbox; bats --tap *.bats

clean:
	rm -rf *.iso *.box

.PHONY: clean prepare build test test-virtualbox

build: boot2docker.iso
	time (packer build -parallel=false template.json)

prepare: clean boot2docker.iso

boot2docker.iso:
	wget -O boot2docker.iso https://github.com/boot2docker/boot2docker/releases/download/v1.5.0/boot2docker.iso

clean:
	rm -rf *.iso *.box

.PHONY: clean prepare build

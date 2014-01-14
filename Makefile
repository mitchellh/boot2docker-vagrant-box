
all: virtualbox vmware

prep:
	mkdir -p boxes/virtualbox
	mkdir -p boxes/vmware

virtualbox: prep boxes/virtualbox/boot2docker.box

vmware: prep boxes/vmware/boot2docker.box

boxes/virtualbox/boot2docker.box: boot2docker.iso
	packer build -only=virtualbox-iso template.json

boxes/vmware/boot2docker.box: boot2docker.iso
	packer build -only=vmware-iso template.json

boot2docker.iso:
	curl -LO https://github.com/steeve/boot2docker/releases/download/v0.4.0/boot2docker.iso

clean:
	rm -f boot2docker.iso
	rm -f *.box
	rm -rf boxes/
	rm -rf output-*/

.PHONY: clean all prep

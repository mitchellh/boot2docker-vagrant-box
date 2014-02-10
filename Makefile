boot2docker.box: boot2docker.iso
	VBoxManage closemedium disk persistent.vmdk
	-VBoxManage closemedium disk persistent2.vmdk
	rm -rf persistent2.vmdk
	VBoxManage clonehd persistent.vmdk persistent2.vmdk
	packer build template.json

boot2docker.iso:
	curl -LO https://github.com/steeve/boot2docker/releases/download/v0.5.4/boot2docker.iso

clean:
	rm -f boot2docker.iso
	rm -f *.box
	rm -rf output-*/

.PHONY: clean

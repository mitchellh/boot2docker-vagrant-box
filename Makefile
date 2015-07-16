build:
	time (packer build -parallel=false template.json)

prepare: clean build

clean:
	rm -rf *.iso *.box
	rm -rf .vagrant
	rm -rf packer_cache


.PHONY: clean prepare build

#!/bin/bash

# Build from original boot2docker git repo, you can provide a branch/id/tag
if [ -n "$1" ] && [ "from-b2d" = "$1" ]; then
	git clone https://github.com/boot2docker/boot2docker
	if [[ -n "$2" ]]; then
		cd boot2docker
		git checkout "$2"
		cd -
	fi
	docker build -t boot2docker/boot2docker:latest boot2docker/
	rm -rf boot2docker
	docker build -t my-boot2docker .
	CID=$(docker run -d my-boot2docker)
	docker cp ${CID}:/boot2docker.iso ./
else	
	#The vagrant up will build the iso and copy it locally
	vagrant up --provider=docker
	vagrant destroy -f
fi




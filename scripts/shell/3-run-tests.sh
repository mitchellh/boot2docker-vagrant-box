#!/bin/bash

SANDBOX="tmp"
BOX_NAME="b2d-test"
BOX_FILE="boot2docker_virtualbox.box"
TESTS_DIR="tests"
CURRENT_DIR=$(dirname $0)


# Clean sandbox
clean_sandbox() {
	if [[ -d "$SANDBOX" ]];then
		cd "$SANDBOX"
		vagrant destroy -f
		vagrant box remove "$BOX_NAME"
		cd -
		rm -rf "$SANDBOX"
	fi
		
}

init_sandbox() {
	clean_sandbox
	cp -r "$TESTS_DIR" "$SANDBOX"
	vagrant box add "$BOX_NAME" "$BOX_FILE"
	cd "$SANDBOX"
	vagrant init "$BOX_NAME"
	cd -
}

init_sandbox
cd "$SANDBOX"
vagrant up

# If we have bats already installed, nothing to do
if [[ ! -x ./bats/bin/bats ]]; then
	rm -rf bats
	git clone https://github.com/sstephenson/bats
	chmod a+x ./bats/bin/bats
fi

./bats/bin/bats --tap *.bats

cd -
clean_sandbox


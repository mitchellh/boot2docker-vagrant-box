#!/bin/bash

SANDBOX="tmp"
BOX_NAME="b2d-test"
BOX_FILE="boot2docker_virtualbox.box"
TESTS_DIR="tests"


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
vagrant ssh -c 'whoami'
vagrant ssh -c "[ $(ls /vagrant | grep install_bats | wc -l) -eq 1 ] || exit 1"
vagrant ssh -c "/bin/bash /vagrant/install_bats.sh"
vagrant ssh -c "/vagrant/bats/bin/bats --tap /vagrant/*.bats"
cd -
clean_sandbox


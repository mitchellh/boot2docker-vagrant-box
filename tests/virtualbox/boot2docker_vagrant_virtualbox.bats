#!/usr/bin/env bats

# Given i'm already in a Vagrantfile-ized folder
# And the basebox has already been added to vagrant

@test "We can vagrant up the VM with basic settings" {
	# Ensure the VM is stopped
	run vagrant destroy -f
	run vagrant box remove boot2docker-virtualbox-test
	cp vagrantfile.orig Vagrantfile
	vagrant up
	[ $( vagrant status | grep 'running' | wc -l ) -ge 1 ]
}

@test "Vagrant can ssh to the VM" {
	vagrant ssh -c 'echo OK'
}

@test "Default ssh user has sudoers rights" {
	[ "$(vagrant ssh -c 'sudo whoami' -- -n -T)" == "root" ]
}

@test "Docker client exists in the remote VM" {
	vagrant ssh -c 'which docker'
}

@test "Docker is working inside the remote VM " {
	vagrant ssh -c 'docker ps'
}

DOCKER_TARGET_VERSION=1.6.2
@test "Docker is version DOCKER_TARGET_VERSION=${DOCKER_TARGET_VERSION}" {
	DOCKER_VERSION=$(vagrant ssh -c "docker version | grep 'Client version' | awk '{print \$3}'" -- -n -T)
	[ "${DOCKER_VERSION}" == "${DOCKER_TARGET_VERSION}" ]
}

@test "My bootlocal.sh script, should have been run at boot" {
	[ $(vagrant ssh -c 'grep OK /tmp/token-boot-local | wc -l' -- -n -T) -eq 1 ]
}

@test "We can reboot the VM properly" {
	vagrant reload
	vagrant ssh -c 'echo OK'
}

@test "We can share folder thru vboxsf" {
	vagrant ssh -c "ls -l /vagrant/Vagrantfile"
}

@test "Rsync is installed inside the b2d" {
	vagrant ssh -c "which rsync"
}

@test "The NFS client is started inside the VM" {
	[ $(vagrant ssh -c 'ps aux | grep rpc.statd | wc -l' -- -n -T) -ge 1 ]
}

@test "We shave a default synced folder thru vboxsf instead of NFS if NO_B2D_NFS_SYNC is set" {
	[ $(vagrant ssh -c 'df -h /vagrant | grep vagrant | grep none | wc -l' -- -n -T) -ge 1 ]
}

@test "We shave a NFS synced folder if B2D_NFS_SYNC is set (admin password required, will fail on Windows)" {
	export B2D_NFS_SYNC=1
	vagrant reload
	[ $(vagrant ssh -c 'df -h /vagrant | grep vagrant | grep 192.168.10.1 | wc -l' -- -n -T) -ge 1 ]
	unset B2D_NFS_SYNC
}

@test "We can share folder thru rsync" {
	sed 's/#SYNC_TOKEN/config.vm.synced_folder ".", "\/vagrant", type: "rsync"/g' vagrantfile.orig > Vagrantfile
	vagrant reload
	[ $( vagrant status | grep 'running' | wc -l ) -ge 1 ]
	vagrant ssh -c "ls -l /vagrant/Vagrantfile"
}

@test "I can stop the VM" {
	vagrant halt
}

@test "I can destroy and clean the VM" {
	vagrant destroy -f
	vagrant box remove boot2docker-virtualbox-test
}

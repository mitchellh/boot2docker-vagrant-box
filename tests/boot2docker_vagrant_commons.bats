#!/usr/bin/env bats

# Given i'm already in a Vagrantfile-ized folder
# And the basebox has already been added to vagrant

@test "We can vagrant up the VM with basic settings" {
	# Ensure the VM is stopped
	run vagrant destroy -f
	vagrant up
}

@test "Vagrant says the VM is running " {
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

@test "Docker remote service is started (init point of view)" {
	vagrant ssh -c 'sudo /etc/init.d/docker status'
}

@test "Docker is working inside the remote VM " {
	vagrant ssh -c 'docker ps'
}

@test "My bootlocal.sh script, should have been run at boot" {
	[ $(vagrant ssh -c 'grep OK /tmp/token-boot-local | wc -l' -- -n -T) -eq 1 ]
}

@test "We can reboot the VM properly" {
	vagrant reload
	vagrant ssh -c 'echo OK'
}

@test "Rsync is installed inside the b2d" {
	vagrant ssh -c "which rsync"
}

@test "I can stop the VM" {
	vagrant halt
}

@test "I can destroy the VM" {
	vagrant destroy -f
}

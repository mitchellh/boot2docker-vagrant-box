#!/usr/bin/env bats

@test "Current user is docker" {
	[ "$(whoami)" == "docker" ]
}

@test "Current user has sudoers rights" {
	[ "$(sudo whoami)" == "root" ]
}

@test "We correctly have access to the Vagrantfile thru /vagrant" {
	[ $(ls -l /vagrant | grep Vagrantfile | wc -l) -ge 1 ]
}


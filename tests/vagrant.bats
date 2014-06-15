#!/usr/bin/env bats

@test "Current user is docker" {
	vagrant ssh -c '[ "$(whoami)" == "docker" ]'
}

@test "Current user has sudoers rights" {
	vagrant ssh -c '[ "$(sudo whoami)" == "root" ]'
}

@test "We correctly have access to the Vagrantfile thru /vagrant" {
	vagrant ssh -c '[ $(ls -l /vagrant | grep Vagrantfile | wc -l) -ge 1 ]'
}


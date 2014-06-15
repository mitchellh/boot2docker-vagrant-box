#!/usr/bin/env bats

@test "Docker bin exists and is in the PATH" {
	vagrant ssh -c "which docker"
}

@test "Docker dameon is running" {
	vagrant ssh -c "[ $(ps aux | grep 'docker -d' | wc -l) -ge 1 ]"
}

@test "Docker client can connect to docker daemon" {
	vagrant ssh -c "docker ps"
}

@test "Docker can reach the INTERNET" {
	vagrant ssh -c "docker search centos"
}

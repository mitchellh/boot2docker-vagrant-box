#!/usr/bin/env bats

@test "Docker bin exists and is in the PATH" {
	which docker
}

@test "Docker dameon is running" {
	[ $(ps aux | grep 'docker -d' | wc -l) -ge 1 ]
}

@test "Docker client can connect to docker daemon" {
	docker ps
}

@test "Docker can reach the INTERNET" {
	docker search centos
}

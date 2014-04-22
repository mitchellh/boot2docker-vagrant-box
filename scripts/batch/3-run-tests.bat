
REM Cleaning tmp dir
@echo off
if exist tmp (
	cd tmp
	vagrant destroy -f
	cd ..
	rmdir /s /q tmp
)

REM Adding basebox
vagrant box remove boot2docker
vagrant box add boot2docker boot2docker_virtualbox.box

REM Creating tmp VM
mkdir tmp
cd tmp
vagrant init boot2docker
vagrant up


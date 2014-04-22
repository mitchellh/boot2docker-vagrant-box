REM Booting the build VM 
vagrant up

REM Building custom iso from b2d
vagrant ssh -c 'cd /vagrant; /usr/bin/sudo /bin/bash /vagrant/build-iso.sh' -- -n -T

REM Stopping VM
vagrant suspend

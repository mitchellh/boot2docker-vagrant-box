
REM Building b2d with vbox
cd b2d-vbox
vagrant up
vagrant destroy -f
cd ..

REM Building b2d vagranted from mitchellh workflow
vagrant up
vagrant ssh -c 'cd /vagrant && sudo ./build-iso.sh' -- -t -n
vagrant destroy -f

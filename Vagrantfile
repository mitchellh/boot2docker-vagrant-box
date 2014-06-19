# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = "dduportal/boot2docker"

	config.vm.provider "virtualbox" do |v|
		v.customize ["modifyvm", :id, "--memory", "2048"]
	end

	# Use devicemapper instead of AUFS. Slower for build, but override the AUFS numbered layer limitation
	config.vm.provision "shell", inline: "echo 'DOCKER_STORAGE=devicemapper' >> /var/lib/boot2docker/profile"
	config.vm.provision "shell", inline: "sudo /etc/init.d/docker restart" 
	
	# Build and create our b2d custom image
	config.vm.provision "shell", inline: "docker build -t my-b2d /vagrant/ && docker run --rm my-b2d > /vagrant/b2d.iso"

end

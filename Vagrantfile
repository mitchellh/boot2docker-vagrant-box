# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu-1204-docker-misheshka"
  config.vm.box_url = "https://dl.dropboxusercontent.com/s/lz7hwjx5utle8ty/ubuntu1204-docker.box"

  config.cache.auto_detect = true
  
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "1500"]
  end
end

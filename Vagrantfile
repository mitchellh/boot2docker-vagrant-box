# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "phusion/ubuntu-14.04-amd64"

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "1500"]
  end

  config.vm.provider "parallels" do |v, override|
    override.vm.box = "parallels/ubuntu-14.04"
    v.memory = 1500
  end

  config.vm.provider :vmware_fusion do |v|
      v.name = "boot2docker"
      v.vmx["memsize"] = "1500"
      v.gui = false
      v.vmx["vhv.enable"] = "TRUE" #Enable nested hypervisors to run x64 OS
  end
end

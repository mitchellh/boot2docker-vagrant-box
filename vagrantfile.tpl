Vagrant.configure("2") do |config|
  config.ssh.shell = "sh"
  config.ssh.username = "docker"

  # Used on Vagrant >= 1.7.x to disable the ssh key regeneration
  config.ssh.insert_key = false

  # Expose the Docker ports (non secured AND secured)
  config.vm.network "forwarded_port", guest: 2375, host: 2375, host_ip: "127.0.0.1", auto_correct: true, id: "docker"
  config.vm.network "forwarded_port", guest: 2376, host: 2376, host_ip: "127.0.0.1", auto_correct: true, id: "docker-ssl"

  # Create a private network for accessing VM without NAT
  config.vm.network "private_network", ip: "192.168.10.10", id: "default-network"

  # Add bootlocal support
  if File.file?('./bootlocal.sh')
    config.vm.provision "shell", path: "bootlocal.sh", run: "always"
  end

  # Attach the ISO
  config.vm.provider "virtualbox" do |v|
    v.customize "pre-boot", [
      "storageattach", :id,
      "--storagectl", "IDE Controller",
      "--port", "0",
      "--device", "1",
      "--type", "dvddrive",
      "--medium", File.expand_path("../boot2docker.iso", __FILE__),
    ]
  end

  ["vmware_fusion", "vmware_workstation"].each do |vmware|
    config.vm.provider vmware do |v|
      v.vmx["bios.bootOrder"]    = "CDROM,hdd"
      v.vmx["ide1:0.present"]    = "TRUE"
      v.vmx["ide1:0.fileName"]   = File.expand_path("../boot2docker.iso", __FILE__)
      v.vmx["ide1:0.deviceType"] = "cdrom-image"
    end
  end

  config.vm.provider "parallels" do |v|
    v.customize "pre-boot", [
      "set", :id,
      "--device-add", "cdrom",
      "--enable", "--connect",
      "--image", File.expand_path("../boot2docker.iso", __FILE__)
    ]
    v.customize "pre-boot", [
      "set", :id,
      "--device-bootorder", "cdrom0 hdd0"
    ]
  end
end

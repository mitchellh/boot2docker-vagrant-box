Vagrant.configure("2") do |config|
  config.ssh.shell = "sh"
  config.ssh.username = "docker"

  # Disable synced folders because guest additions aren't available
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Expose the Docker port
  config.vm.network "forwarded_port", guest: 2375, host: 2375, host_ip: "127.0.0.1", auto_correct: true, id: "docker"

  # Attach the ISO
  config.vm.provider "virtualbox" do |v|
    v.customize "pre-boot", [
      "storageattach", :id,
      "--storagectl", "IDE Controller",
      "--port", "0",
      "--device", "1",
      "--type", "dvddrive",
      "--medium", File.expand_path("../boot2docker-vagrant.iso", __FILE__),
    ]
  end

  ["vmware_fusion", "vmware_workstation"].each do |vmware|
    config.vm.provider vmware do |v|
      v.vmx["bios.bootOrder"]    = "CDROM,hdd"
      v.vmx["ide1:0.present"]    = "TRUE"
      v.vmx["ide1:0.fileName"]   = File.expand_path("../boot2docker-vagrant.iso", __FILE__)
      v.vmx["ide1:0.deviceType"] = "cdrom-image"
    end
  end

  config.vm.provider "parallels" do |v|
    v.customize "pre-boot", [
      "set", :id,
      "--device-add", "cdrom",
      "--enable", "--connect",
      "--image", File.expand_path("../boot2docker-vagrant.iso", __FILE__)
    ]
    v.customize "pre-boot", [
      "set", :id,
      "--device-bootorder", "cdrom0 hdd0"
    ]
  end
end

Vagrant.configure("2") do |config|
  config.ssh.shell = "sh"
  config.ssh.username = "docker"
  config.ssh.password = "tcuser"

  # Expose the Docker port
  config.vm.network "forwarded_port", guest: 2375, host: 2375,
    host_ip: "127.0.0.1", auto_correct: true, id: "docker"

  # b2d doesn't support NFS
  config.nfs.functional = false

  # b2d doesn't persist filesystem between reboots
  if config.ssh.respond_to?(:insert_key)
    config.ssh.insert_key = false
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

    # On VirtualBox, we don't have guest additions or a functional vboxsf
    # in TinyCore Linux, so tell Vagrant that so it can be smarter.
    v.check_guest_additions = false
    v.functional_vboxsf     = false
  end

  ["vmware_fusion", "vmware_workstation"].each do |vmware|
    config.vm.provider vmware do |v|
      v.vmx["bios.bootOrder"]    = "CDROM,hdd"
      v.vmx["ide1:0.present"]    = "TRUE"
      v.vmx["ide1:0.fileName"]   = File.expand_path("../boot2docker.iso", __FILE__)
      v.vmx["ide1:0.deviceType"] = "cdrom-image"

      if v.respond_to?(:functional_hgfs=)
        v.functional_hgfs = false
      end
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

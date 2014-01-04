Vagrant.configure("2") do |config|
  config.ssh.username = "docker"

  config.vm.base_mac = "{{ .BaseMacAddress }}"
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
end

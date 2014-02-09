Vagrant.configure("2") do |config|
  config.ssh.shell = "sh -l"
  config.ssh.username = "docker"

  # Disable synced folders because guest additions aren't available
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Setting VM networking
  config.vm.network "forwarded_port", guest: 4243, host: 4243
end

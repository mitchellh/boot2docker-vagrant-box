Vagrant.configure("2") do |config|

	config.vm.define "my-boot2docker" do |v|
  		v.vm.provider "docker" do |d|
    			d.build_dir = "."
    			d.cmd = ["/usr/sbin/sshd","-D"]
    			d.has_ssh = true
  		end

		v.ssh.username = "root"
		v.ssh.password = "vagrant"

		v.vm.provision "shell", inline: "cp /boot2docker.iso /vagrant/boot2docker-vagrant.iso && chown $(ls -al /vagrant | head -n2 | tail -n1 | awk '{print $3}') /vagrant/boot2docker-vagrant.iso"

		v.vm.synced_folder ".", "/vagrant"
	end
end

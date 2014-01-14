# Core Linux guest support from https://github.com/fnichol/dvm/blob/master/Vagrantfile
module VagrantPlugins
  module GuestTcl
    module Cap ; end

    class Plugin < Vagrant.plugin("2")
      name "Core Linux guest"
      description "Core Linux guest support"

      guest("tcl", "linux") do
        class ::VagrantPlugins::GuestTcl::Guest < Vagrant.plugin("2", :guest)
          def detect?(machine)
            machine.communicate.test("cat /etc/issue | grep 'Core Linux'")
          end
        end
        Guest
      end

      guest_capability("tcl", "halt") do
        class ::VagrantPlugins::GuestTcl::Cap::Halt
          def self.halt(machine)
            machine.communicate.sudo("poweroff")
          rescue IOError
            # Do nothing, because it probably means the machine shut down
            # and SSH connection was lost.
          end
        end
        Cap::Halt
      end

      guest_capability("tcl", "configure_networks") do
        class ::VagrantPlugins::GuestTcl::Cap::ConfigureNetworks
          def self.configure_networks(machine, networks)
            require 'ipaddr'
            machine.communicate.tap do |comm|
              networks.each do |n|
                ifc = "/sbin/ifconfig eth#{n[:interface]}"
                broadcast = (IPAddr.new(n[:ip]) | (~ IPAddr.new(n[:netmask]))).to_s
                comm.sudo("#{ifc} down")
                comm.sudo("#{ifc} #{n[:ip]} netmask #{n[:netmask]} broadcast #{broadcast}")
                comm.sudo("#{ifc} up")
              end
            end
          end
        end
        Cap::ConfigureNetworks
      end
    end
  end
end

Vagrant.configure("2") do |config|
  config.ssh.shell = "sh -l"
  config.ssh.username = "docker"

  # Disable synced folders because guest additions aren't available
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Attach the b2d ISO so it can boot
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

  config.vm.provider "vmware_fusion" do |v|
    v.vmx["bios.bootorder"] = "CDROM,hdd"
    v.vmx["ide1:0.present"] = "true"
    v.vmx["ide1:0.deviceType"] = "cdrom-image"
    v.vmx["ide1:0.fileName"] = File.expand_path("../boot2docker.iso", __FILE__)
  end

  config.vm.provider "vmware_desktop" do |v|
    v.vmx["bios.bootorder"] = "CDROM,hdd"
    v.vmx["ide1:0.present"] = "true"
    v.vmx["ide1:0.deviceType"] = "cdrom-image"
    v.vmx["ide1:0.fileName"] = File.expand_path("../boot2docker.iso", __FILE__)
  end
end

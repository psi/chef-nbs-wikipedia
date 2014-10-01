# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "chef/ubuntu-12.04"

  config.omnibus.chef_version = "11.16.2"
  config.berkshelf.enabled = true

  config.vm.define "mongo1" do |master|
    master.vm.hostname = "mongo1"
    master.vm.network "private_network", ip: "192.168.48.91"

    master.vm.provision "chef_solo" do |chef|
      chef.add_recipe "nbs-wikipedia::default"
    end
  end
end

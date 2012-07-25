# -*- mode: ruby -*-
# vi: set ft=ruby sw=2 :

require './vagrant-mongo/lib/vagrant-mongo.rb'

Vagrant::Config.run do |config|

    config.vm.box = "replicaset"
    config.vm.box_url = "http://files.vagrantup.com/lucid64.box"

    config.vm.network :hostonly, "192.168.1.2"
    config.vm.host_name = "replicaset.local"

    (17..21).each do |p|
      config.vm.forward_port 37000 + p, 37100 + p
    end

    config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "mongo_rs.pp"
      puppet.module_path    = "puppet/modules"
    end

end

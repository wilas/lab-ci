# -*- mode: ruby -*-
# vi: set ft=ruby :

# Docs: 
# machine settings: http://docs.vagrantup.com/v2/vagrantfile/machine_settings.html
# provider configruation: http://docs.vagrantup.com/v2/providers/configuration.html

Vagrant.configure("2") do |config|

  config.vm.define :grocery do |node_config|
    vm_name= "grocery"
    node_config.vm.box = "SL6"
    node_config.vm.hostname = "#{vm_name}.farm"

    node_config.vm.provider :virtualbox do |vb|
        vb.name = "#{vm_name}"
        vb.customize ["modifyvm", :id, "--memory", "512"]
    end

    node_config.vm.network :private_network, ip: "77.77.77.131"
    node_config.vm.synced_folder ".", "/vagrant"

    node_config.vm.provision :puppet do |puppet|
        puppet.options = "--hiera_config hiera.yaml"
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "grocery.pp"
        puppet.module_path = "modules"
    end
  end

  config.vm.define :cook do |node_config|
    vm_name= "cook"
    node_config.vm.box = "SL6"
    node_config.vm.hostname = "#{vm_name}.farm"
    
    node_config.vm.provider :virtualbox do |vb|
        vb.name = "#{vm_name}"
        vb.customize ["modifyvm", :id, "--memory", "2048"]
    end

    node_config.vm.network :private_network, ip: "77.77.77.132"
    node_config.vm.synced_folder ".", "/vagrant"

    node_config.vm.provision :puppet do |puppet|
        puppet.options = "--hiera_config hiera.yaml"
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "cook.pp"
        puppet.module_path = "modules"
    end
  end

  config.vm.define :locro do |node_config|
    vm_name= "locro"
    node_config.vm.box = "SL6"
    node_config.vm.hostname = "#{vm_name}.farm"
    
    node_config.vm.provider :virtualbox do |vb|
        vb.name = "#{vm_name}"
        vb.customize ["modifyvm", :id, "--memory", "512"]
    end

    node_config.vm.network :private_network, ip: "77.77.77.133"
    node_config.vm.synced_folder ".", "/vagrant"

    node_config.vm.provision :puppet do |puppet|
        puppet.options = "--hiera_config hiera.yaml"
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "locro.pp"
        puppet.module_path = "modules"
    end
  end
end

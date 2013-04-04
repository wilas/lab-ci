# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  config.vm.define :grocery do |node_config|
    vm_name= "grocery"
    node_config.vm.box = "SL6"
    node_config.vm.host_name = "#{vm_name}.farm"
    node_config.vm.customize ["modifyvm", :id, "--memory", "512", "--name", "#{vm_name}"]

    node_config.vm.network :hostonly, "77.77.77.131"
    node_config.vm.share_folder "v-root", "/vagrant", "."

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
    node_config.vm.host_name = "#{vm_name}.farm"
    node_config.vm.customize ["modifyvm", :id, "--memory", "2048", "--name", "#{vm_name}"]

    node_config.vm.network :hostonly, "77.77.77.132"
    node_config.vm.share_folder "v-root", "/vagrant", "."

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
    node_config.vm.host_name = "#{vm_name}.farm"
    node_config.vm.customize ["modifyvm", :id, "--memory", "512", "--name", "#{vm_name}"]

    node_config.vm.network :hostonly, "77.77.77.133"
    node_config.vm.share_folder "v-root", "/vagrant", "."

    node_config.vm.provision :puppet do |puppet|
        puppet.options = "--hiera_config hiera.yaml"
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "locro.pp"
        puppet.module_path = "modules"
    end
  end
end


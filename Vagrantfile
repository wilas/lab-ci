# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  config.vm.define :grocery do |config|
    vm_name= "grocery"
    config.vm.box = "SL64_box"
    config.vm.host_name = "#{vm_name}.farm"
    config.vm.customize ["modifyvm", :id, "--memory", "512", "--name", "#{vm_name}"]

    config.vm.network :hostonly, "77.77.77.131"
    config.vm.share_folder "v-root", "/vagrant", "."

    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "grocery.pp"
        puppet.module_path = "modules"
    end
  end

  config.vm.define :cook do |config|
    vm_name= "cook"
    config.vm.box = "SL64_box"
    config.vm.host_name = "#{vm_name}.farm"
    config.vm.customize ["modifyvm", :id, "--memory", "2048", "--name", "#{vm_name}"]

    config.vm.network :hostonly, "77.77.77.132"
    config.vm.share_folder "v-root", "/vagrant", "."

    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "cook.pp"
        puppet.module_path = "modules"
    end
  end

end

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  config.vm.define :guillotine do |config|
    vm_name= "guillotine"
    config.vm.box = "SL64_box"
    config.vm.host_name = "#{vm_name}.soup"
    config.vm.customize ["modifyvm", :id, "--memory", "512", "--name", "#{vm_name}"]

    config.vm.network :hostonly, "77.77.77.131"
    config.vm.share_folder "v-root", "/vagrant", "."

    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "guillotine.pp"
        puppet.module_path = "modules"
    end
  end

end

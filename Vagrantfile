# -*- mode: ruby -*-
# vi: set ft=ruby :
ENV['VAGRANT_NO_PARALLEL'] = 'yes'
Vagrant.configure(2) do |config|
  config.vm.provision "shell", path: "init.sh"


  # Master Definition.
  config.vm.define "kube-master" do |master|
    master.vm.box               = "centos/stream8"
    master.vm.box_check_update  = false
    # master.vm.box_version       = "20210210.0"
    master.vm.hostname          = "kube-master.example.com"
    master.vm.network "private_network", ip: "192.168.122.100"
    # master.vm.provider :virtualbox do |vbox|
    #   vbox.name    = "kube-master"
    #   vbox.memory  = 2048
    #   vbox.cpus    =  2
    # end
    master.vm.provider :libvirt do |kvm|
      kvm.memory  = 2048
      kvm.nested  = true
      kvm.cpus    = 2
    end
    master.vm.provision "shell", path: "kube-master-init.sh"
  end
  # Node Definition.
  nodecount = 2
  (1..nodecount).each do |i|
    config.vm.define "kube-node#{i}" do |node|
      node.vm.box               = "centos/stream8"
      node.vm.box_check_update  = false
      # node.vm.box_version       = "20210210.0"
      node.vm.hostname          = "kube-node#{i}.example.com"
      node.vm.network "private_network", ip: "192.168.122.10#{i}"
      # node.vm.provider :virtualbox do |vbox|
      #   vbox.name    = "kube-master"
      #   vbox.memory  = 2048
      #   vbox.cpus    =  2
      # end
      node.vm.provider :libvirt do |kvm|
        kvm.memory  = 2048
        kvm.nested  = true
        kvm.cpus    = 2
      end
      node.vm.provision "shell", path: "kube-node-init.sh"
    end
  end
end

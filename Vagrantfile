# -*- mode: ruby -*-
# vi: set ft=ruby :
ENV['VAGRANT_NO_PARALLEL'] = 'yes'
Vagrant.configure(2) do |config|
  config.vm.provision "shell", path: "./includes/00-init.sh"


  # Master Definition
  config.vm.define "kube-master" do |master|
    master.vm.box               = "centos/stream8"
    master.vm.box_check_update  = false
    master.vm.hostname          = "kube-master.example.com"
    master.vm.network "private_network", ip: "192.168.122.100"
    master.vm.provider :libvirt do |kvm|
      kvm.memory  = 2048
      kvm.nested  = true
      kvm.cpus    = 2
    end
    master.vm.provision "shell", path: "./includes/10-kube-master-init.sh"
  end
  # Node Definition
  nodecount = 2
  (1..nodecount).each do |i|
    config.vm.define "kube-node#{i}" do |node|
      node.vm.box               = "centos/stream8"
      node.vm.box_check_update  = false
      node.vm.hostname          = "kube-node#{i}.example.com"
      node.vm.network "private_network", ip: "192.168.122.10#{i}"
      node.vm.provider :libvirt do |kvm|
        kvm.memory  = 2048
        kvm.nested  = true
        kvm.cpus    = 2
      end
      node.vm.provision "shell", path: "./includes/30-kube-node-init.sh"
    end
  end
end

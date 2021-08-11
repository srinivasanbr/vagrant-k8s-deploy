## Pre-requisites      
### Install Vagrant and Libvirt        
Installation instructions [here](./docs/install-vagrant-libvirt.md)       

## Deploy K8s           
Clone this repository         
```bash
git clone https://github.com/srinivasanbr/vagrant-k8s-deploy.git
```
Launch VM's   
```bash
vagrant up
```
Check status of VM's     
```bash
vagrant status
```
SSH into the boxes       
```bash
vagrant ssh kube-master
vagrant ssh kube-node1
vagrant ssh kube-node2
```

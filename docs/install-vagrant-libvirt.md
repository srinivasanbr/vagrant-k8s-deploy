## Table of Contents    
1) [Install Vagrant](#)   
2) [Install vagrant-libvirt](#)    

## Install Vagrant    
Locate and install the appropriate `vagrant` package for your distribution either via the package manager or fetch the binary right from the official website. If all goes well, the installer will place the `vagrant` binary inside your system's $PATH, after which you can call it from anywhere within the terminal   

- [Download Vagrant](https://www.vagrantup.com/downloads)    

- CentOS / RHEL   
```bash   
sudo yum install -y yum-utils    
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo     
sudo yum -y install vagrant   
```   

- Ubuntu / Debian    
```bash    
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -    
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"    
sudo apt-get update && sudo apt-get install vagrant    
```    


## Install vagrant-libvirt    
- This is a Vagrant plugin that adds a Libvirt provider to Vagrant, allowing Vagrant to control and provision machines via Libvirt toolkit.    
- First, you should have both QEMU and Libvirt installed if you plan to run VMs on your local system. For instructions, refer to your Linux distribution's documentation.    
- Now you need to make sure your have all the build dependencies installed for vagrant-libvirt. This depends on your distro.    
- Ubuntu 18.04 / Debian 8    
```bash    
apt-get install -y qemu libvirt-bin ebtables dnsmasq-base    
apt-get install -y libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev    
apt-get install -y libguestfs-tools    
```    
- CentOS 7 / RHEL 7    
```bash    
yum install -y qemu libvirt libvirt-devel ruby-devel gcc qemu-kvm libguestfs-tools     
```    
- Vagrant needs to be informed that Libvirt is the default and preferred driver and not VirtualBox. So pass the `--provider=libvirt` option to specify it. If you are unsure and simply want to test this script, you can always set an environment variable and continue to execute the rest   
```bash    
export VAGRANT_DEFAULT_PROVIDER=libvirt    
```    
- To install `vagrant-libvirt` plugin.    

```bash    
vagrant plugin install vagrant-libvirt    
```    
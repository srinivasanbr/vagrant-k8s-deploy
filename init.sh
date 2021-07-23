#!/bin/bash

# This script is tested on CentOS 7 and 8

echo '#####################################'
echo "# Job 1 : Disable and turn off SWAP #"
echo '#####################################'
sed -i "s/\/swapfile/\#\/swapfile/g" /etc/fstab
cat /etc/fstab
swapoff -a

echo -e "\n \n"
echo '#####################################'
echo "# Job 2 : Enable and start Firewall #"
echo '#####################################'
systemctl enable firewalld.service
systemctl start firewalld.service
systemctl status firewalld.service

echo -e "\n \n"
echo '###########################'
echo "# Job 3 : Disable SELinux #"
echo '###########################'
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
setenforce 0

echo -e "\n \n"
echo '###############################'
echo "# Job 4 : Add Kernel settings #"
echo '###############################'
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
EOF
sysctl --system >/dev/null 2>&1

echo -e "\n \n"
echo '#################################'
echo "# Job 5 : Add Docker Repository #"
echo '#################################'
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

echo -e "\n \n"
echo '###############################################'
echo "# Job 6 : Install containerd.io and Docker-CE #"
echo '###############################################'
dnf -y install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
dnf -y install docker-ce

echo -e "\n \n"
echo '############################################'
echo "# Job 7 : Enable and Start  docker Service #"
echo '############################################'
systemctl enable docker
systemctl start docker
systemctl status docker

echo -e "\n \n"
echo '###############################'
echo "# Job 8 : Add Kubernetes Repo #"
echo '###############################'
cat >> /etc/yum.repos.d/kubernetes.repo<<EOF
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

echo -e "\n \n"
echo '##############################'
echo "# Job 9 : Install Kubernetes #"
echo '##############################'
dnf install -y kubelet kubeadm kubectl

echo -e "\n \n"
echo '###################################'
echo "# Job 10 Enable and Start kubelet #"
echo '###################################'
systemctl enable kubelet
systemctl start kubelet
systemctl status kubelet

echo -e "\n \n"
echo '###################################'
echo "# Job 11 : Update /etc/hosts file #"
echo '###################################'
cat >>/etc/hosts<<EOF
192.168.122.100  kube-master.example.com     master   kube-master
192.168.122.101  kube-worker1.example.com    worker1  kube-worker1
192.168.122.102  kube-worker2.example.com    worker2  kube-worker2
EOF

echo -e "\n \n"
echo '#######################################'
echo "# Job 12 : Updated Root user Password #"
echo '#######################################'
echo -e "kubeadmin" | passwd --stdin root
sed -i 's/PasswordAuthentication\ no/PasswordAuthentication\ yes/g' /etc/ssh/sshd_config
systemctl restart sshd.service

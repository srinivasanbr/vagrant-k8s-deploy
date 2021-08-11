#!/bin/bash

echo '############################################'
echo "#     Allow Required ports on Firewall     #"
echo '############################################'
firewall-cmd --add-port=10250/tcp --per
firewall-cmd --add-port=30000-32767/tcp --per
firewall-cmd --reload

echo -e "\n \n"

echo '#####################################'
echo "#     Copy Cluster Join command     #"
echo '#####################################'
yum install -y https://download-ib01.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/s/sshpass-1.06-9.el8.x86_64.rpm
sshpass -p "kubeadmin" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no master:/join-cluster.sh  /join-cluster.sh

echo -e "\n \n"
echo '########################'
echo "#     Join Cluster     #"
echo '########################'
bash /join-cluster.sh

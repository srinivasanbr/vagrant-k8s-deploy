# #!/bin/bash

echo '############################################'
echo "#     Allow Required ports on Firewall     #"
echo '############################################'
firewall-cmd --add-port=443/tcp --per
firewall-cmd --add-port=2379/tcp --per
firewall-cmd --add-port=2380/tcp --per
firewall-cmd --add-port=10250/tcp --per
firewall-cmd --add-port=10251/tcp --per
firewall-cmd --add-port=10252/tcp --per
firewall-cmd --reload

echo -e "\n \n"

echo '##########################################'
echo "#     Pull required container images     #"
echo '##########################################'
kubeadm config images pull >/dev/null

echo -e "\n \n"

echo '#########################################'
echo "#     Initialize Kubernetes Cluster     #"
echo '#########################################'
kubeadm init --apiserver-advertise-address=192.168.122.100 --pod-network-cidr=10.244.0.0/16 --apiserver-bind-port=443 >> /root/kubernetes-cluster-init.log

echo -e "\n \n"

echo '###########################################'
echo "#     Deploy kube-flannel Pod Network     #"
echo '###########################################'
kubectl --kubeconfig=/etc/kubernetes/admin.conf apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

echo -e "\n \n"


echo '#########################################'
echo "#     Generate cluster join command     #"
echo '#########################################'
kubeadm token create --print-join-command > /join-cluster.sh

echo -e "\n \n"

echo '#########################################'
echo "#     Enable kubectl autocompletion     #"
echo '#########################################'
echo 'source <(kubectl completion bash)' >>~/.bashrc
kubectl completion bash >/etc/bash_completion.d/kubectl
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -F __start_kubectl k' >>~/.bashrc

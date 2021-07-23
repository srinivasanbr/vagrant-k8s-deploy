### This document provides a How-to for deploying K8s Cluster on VM's using `vagrant`.     

## Table of Contents   
1) [Requirements](#)      
	* [Install Vagrant](#)     
2) [Deploy K8s](#)    

## Pre-requisites      
### Install Vagrant and Libvirt        
Vagrant installation guide is located here. [Install Vagrant](../Docs/install-vagrant-libvirt.md)       

## Deploy K8s           
- Clone this repository         
```bash
git clone https://github.com/srinivasanbr/vagrant-k8s-deploy.git
```
- Start VM's using `vagrant`   
```bash
vagrant up
```
- To check VM's status      
```bash
vagrant status
```
- SSH into the boxes       
```bash
vagrant ssh kube-master
vagrant ssh kube-node1
vagrant ssh kube-node2
```
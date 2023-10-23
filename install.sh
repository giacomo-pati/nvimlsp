#!/bin/sh
echo "$0"

echo "Install prereqs"
sudo apt install software-properties-common
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update
sudo apt install ansible -y

echo "Install Ansible roles"
ansible-galaxy role install lean_delivery.java # tecris.maven

echo "Execute Ansible playboot"
ansible-playbook ansible.yaml

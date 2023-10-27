#!/bin/sh
echo "$0"

echo "Install prereqs"
if [ "$(uname)" = "Darwin" ]; then
  brew install ansible
else
  sudo apt install software-properties-common
  sudo apt-add-repository ppa:ansible/ansible -y
  sudo apt update
  sudo apt install ansible -y

  echo "Install Ansible roles"
  ansible-galaxy role install lean_delivery.java # tecris.maven
fi

echo "Execute Ansible playboot"
if [ "$(uname)" = "Darwin" ]; then
  ansible-playbook macansible.yaml
else
  ansible-playbook ansible.yaml
fi

#!/bin/bash
echo "$0"

echo "Install prereqs"
if [ "$(uname)" = "Darwin" ]; then
  brew install ansible
  echo "Execute Ansible playboot"
  if [ $# -gt 0 ]; then
    ansible-playbook macansible.yaml --start-at-task "$1"
  else
    ansible-playbook macansible.yaml 
  fi
else
  sudo ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
  sudo dpkg-reconfigure -fnoninteractive tzdata
  DEBIAN_FRONTEND="noninteractive" sudo apt install -y tzdata
  sudo apt install software-properties-common -y
  sudo apt-add-repository ppa:ansible/ansible -y
  sudo apt update
  sudo apt install ansible -y
  echo "Install Ansible roles"
  ansible-galaxy role install lean_delivery.java --force --ignore-certs # tecris.maven
  echo "Execute Ansible playboot"
  if [ $# -gt 0 ]; then
    ansible-playbook ansible.yaml --start-at-task "$1"
  else
    ansible-playbook ansible.yaml
  fi
fi

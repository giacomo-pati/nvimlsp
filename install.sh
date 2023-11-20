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
  if [ $# -gt 0 ]; then
    ansible-playbook macansible.yaml --start-at-task "$1"
  else
    ansible-playbook macansible.yaml
  fi
else
  if [ $# -gt 0 ]; then
    ansible-playbook ansible.yaml --start-at-task "$1"
  else
    ansible-playbook ansible.yaml
  fi
fi

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
  echo $PROXY_URL | grep '\.rcbd\.' >/dev/null
  if [ $? -eq 0 ]; then
    echo "We are on a RCBD instance"
    RCBD=true
  else 
    echo "We are NOT on a RCBD instance"
    RCBD=false
    sudo apt install software-properties-common
    sudo apt-add-repository ppa:ansible/ansible -y
    sudo apt update
    sudo apt install ansible -y
  fi
  echo "Install Ansible roles"
  ansible-galaxy role install lean_delivery.java --force -e "rcbd=$RCBD" # tecris.maven
  echo "Execute Ansible playboot"
  if [ $# -gt 0 ]; then
    ansible-playbook ansible.yaml --start-at-task "$1" -e "rcbd=$RCBD"
  else
    ansible-playbook ansible.yaml -e "rcbd=$RCBD"
  fi
fi

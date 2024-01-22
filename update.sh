#!/bin/bash
echo "$0"

if [ "$(uname)" != "Darwin" ]; then
  echo "Update Ansible roles"
  ansible-galaxy role install lean_delivery.java --force # tecris.maven --force
  echo "Execute Ansible playboot"
  if [ $# -gt 0 ]; then
    ansible-playbook macansible.yaml -e "update=true" --start-at-task "$1"
  else
    ansible-playbook macansible.yaml -e "update=true"
  fi
else
  echo "Execute Ansible playboot"
  echo $PROXY_URL | grep '\.rcbd\.' >/dev/null
  if [ $? -eq 0 ]; then
    echo "We are on a RCBD instance"
    RCBD=true
  else 
    echo "We are NOT on a RCBD instance"
    RCBD=false
  fi
  if [ $# -gt 0 ]; then
    ansible-playbook ansible.yaml -e "update=true rcbd=$RCBD" --start-at-task "$1"
  else
    ansible-playbook ansible.yaml -e "update=true rcbd=$RCBD"
  fi
fi

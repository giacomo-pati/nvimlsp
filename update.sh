#!/bin/sh
echo "$0"

if [ "$(uname)" != "Darwin" ]; then
  echo "Update Ansible roles"
  ansible-galaxy role install lean_delivery.java --force # tecris.maven --force
fi

echo "Execute Ansible playboot"
if [ "$(uname)" = "Darwin" ]; then
  if [ $# -gt 0 ]; then
    ansible-playbook macansible.yaml -e "update=true" --start-at-task "$1"
  else
    ansible-playbook macansible.yaml -e "update=true"
  fi
else
  if [ $# -gt 0 ]; then
    ansible-playbook ansible.yaml -e "update=true" --start-at-task "$1"
  else
    ansible-playbook ansible.yaml -e "update=true"
  fi
fi

#!/bin/sh
echo "$0"

if [ "$(uname)" != "Darwin" ]; then
  echo "Update Ansible roles"
  ansible-galaxy role install lean_delivery.java --force # tecris.maven --force
fi

echo "Execute Ansible playboot"
if [ "$(uname)" = "Darwin" ]; then
  ansible-playbook macansible.yaml -e "update=true"
else
  ansible-playbook ansible.yaml -e "update=true"
fi

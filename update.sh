#!/bin/sh
echo "$0"

echo "Update Ansible roles"
ansible-galaxy role install gantsign.golang lean_delivery.java --force # tecris.maven --force

echo "Execute Ansible playboot"
ansible-playbook ansible.yaml -e "update=true"

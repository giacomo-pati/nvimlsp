#!/bin/sh
echo "$0"

echo "Execute Ansible playboot"
ansible-playbook ansible.yaml -e "update=true"

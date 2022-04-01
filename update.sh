#!/bin/sh

# install Ansible roles
sudo ansible-galaxy role install gantsign.golang lean_delivery.java tecris.maven

# root Ansible playboot
sudo ansible-playbook -v ansible-root.yaml

#!/bin/bash

# The commands in this script are meant to be ran by root.

# Install EPEL Repo
yum -y install epel-release

# Install Ansible and Git
yum -y install ansible git

# Clone Repo
git clone -b stage https://github.com/gabotronix/underpass.git /opt/underpass

# Install Ansible Roles
ansible-galaxy install -r /opt/underpass/requirements.yml

# Run Ansible Playbook
cd /opt/underpass
ansible-playbook install.yml

# Install Underpass
docker network create underpass --subnet 172.20.0.0/24
docker-compose up -d
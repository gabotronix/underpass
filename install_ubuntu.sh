#!/bin/bash

# The commands in this script are meant to be ran by root.

# Add Ansible Repo
apt update
apt upgrade -y
apt install -y software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt install -y ansible git

# Clone Repo
git clone -b stage https://github.com/gabotronix/underpass.git /opt/underpass

# Install Ansible Roles
ansible-galaxy install -r /opt/underpass/ansible/requirements.yml

# Run Ansible Playbook
cd /opt/underpass
ansible-playbook -v install.yml

# Install Underpass
docker network create underpass --subnet 172.20.0.0/24
docker-compose up -d

# Enumerate Web UI's and Ports
PublicIP=$(curl -4 ifconfig.co 2>/dev/null)
echo -e "===================================================="
echo -e "The Underpass tunnel has been built!"
echo -e "===================================================="
echo -e "\nConfigure Portainer @ http://$PublicIP:9000\n"
echo -e "Configure Pritunl VPN @ https://$PublicIP:4433\n"
echo -e "Configure Heimdall @ http://$PublicIP:85/users\n"
echo -e "View Server Load @ http://$PublicIP:19999\n"
echo -e "----------------------------------------------------"

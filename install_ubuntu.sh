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
ansible-galaxy install -r /opt/underpass/requirements.yml

# Run Ansible Playbook
cd /opt/underpass
ansible-playbook -v install.yml

# Install Underpass
docker network create underpass --subnet 172.20.0.0/24
docker-compose up -d

# Enumerate Services and Ports
MYIP=$(curl -4 icanhazip.com)
echo " "
echo "UNDERPASS INSTALLATION COMPLETE!"
echo " "
echo "Configure Portainer @ http://$MYIP:9000"
echo "Configure Pritunl VPN Web UI @ https://$MYIP:4433"
echo "Configure Heimdall @ http://$MYIP:85"
echo "View Server Load @ http://$MYIP:19999"

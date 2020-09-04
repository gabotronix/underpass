#!/bin/bash

# The commands in this script are meant to be ran by root.

# update system
yum -y update && yum -y upgrade

# install EPEL repo and ELRepo
yum -y install epel-release elrepo-release

# install git
yum install http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-2.noarch.rpm
sed -i 's|enabled=1|enabled=0|' /etc/yum.repos.d/wandisco-git.repo
yum -y --enablerepo=WANdisco-git update git

# install system tools
yum -y install yum-utils screen nano wget ntp net-tools rsync glances htop ncdu

# install wireguard kernel modules
yum -y install yum-plugin-elrepo kmod-wireguard wireguard-tools

# environment settings
sed -i -e '$ainclude "/usr/share/nano/sh.nanorc"' ~/.nanorc
sed -i -e '$aexport VISUAL=nano' ~/.bashrc
source ~/.bashrc

# install Docker
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce docker-ce-cli containerd.io
systemctl start docker
systemctl enable docker

# install Docker Compose - https://gist.githubusercontent.com/wdullaer/f1af16bd7e970389bad3/raw/4a5a72aece57e1deca926894e5919f90350c706d/install.sh
COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oE "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | sort --version-sort | tail -n 1`
curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose

# install fail2ban
yum -y install fail2ban
curl -o /etc/fail2ban/jail.local https://raw.githubusercontent.com/gabotronix/underpass/stage/config/fail2ban/jail-centos7.local
systemctl start fail2ban
systemctl enable fail2ban

# install Underpass Docker apps
docker network create underpass
cd /home/underpass
docker-compose up -d

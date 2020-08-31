#!/bin/bash

# set working directory
mkdir /usr/local/src/underpass && cd /usr/local/src/underpass

# update system
yum -y update && yum -y upgrade

# install EPEL repo
yum -y install epel-release

# install git
yum install http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-2.noarch.rpm
sed -i 's|enabled=1|enabled=0|' /etc/yum.repos.d/wandisco-git.repo
yum -y --enablerepo=WANdisco-git install git

# install system tools
yum -y install screen nano wget ntp net-tools rsync glances htop ncdu

# environment settings
echo "include \"/usr/share/nano/sh.nanorc\"" > ~/.nanorc
sed -i -e '$aexport VISUAL=nano' ~/.bashrc
source ~/.bashrc

# install dropbear - https://github.com/daybreakersx/premscript
yum -y install dropbear
echo "OPTIONS=\"-p 109 -p 110 -p 442\"" > /etc/sysconfig/dropbear
echo "/bin/false" >> /etc/shells
systemctl start dropbear
systemctl enable dropbear
firewall-cmd --zone=public --add-port=109/tcp --permanent
firewall-cmd --zone=public --add-port=110/tcp --permanent
firewall-cmd --zone=public --add-port=442/tcp --permanent
firewall-cmd --reload

# install cockpit
yum -y install cockpit cockpit-dashboard
systemctl start cockpit.socket
systemctl enable cockpit.socket
firewall-cmd --zone=public --add-port=9090/tcp --permanent
firewall-cmd --reload

# install Docker and Docker Compose
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce docker-ce-cli containerd.io
systemctl start docker
systemctl enable docker

# install Docker Compose - https://gist.githubusercontent.com/wdullaer/f1af16bd7e970389bad3/raw/4a5a72aece57e1deca926894e5919f90350c706d/install.sh
COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oE "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | sort --version-sort | tail -n 1`
curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
chmod +x /usr/local/bin/docker-compose
touch /etc/bash_completion.d/docker-compose
curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"

# install fail2ban
yum -y install fail2ban
curl -o /etc/fail2ban/jail.local https://raw.githubusercontent.com/gabotronix/underpass/stage/config/fail2ban/jail-centos7.local
curl -o /etc/fail2ban/jail.d/dropbear.conf https://raw.githubusercontent.com/gabotronix/underpass/stage/config/fail2ban/dropbear.conf
systemctl start fail2ban
systemctl enable fail2ban

# install wireguard - https://github.com/angristan/wireguard-install
curl -O https://raw.githubusercontent.com/angristan/wireguard-install/master/wireguard-install.sh
chmod +x wireguard-install.sh
./wireguard-install.sh

# wireguard post install
firewall-cmd --zone=public --add-port=5555/udp --permanent
firewall-cmd --reload
rsync -a /usr/local/src/underpass/wireguard-install.sh /usr/local/bin/

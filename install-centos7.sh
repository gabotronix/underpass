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
yum --enablerepo=WANdisco-git install git -y

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

# install cockpit
yum -y install cockpit cockpit-dashboard
systemctl start cockpit.socket
systemctl enable cockpit.socket
firewall-cmd --zone=public --add-port=9090/tcp --permanent
firewall-cmd --reload

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

# add wireguard to path
rsync -a /usr/local/src/underpass/wireguard-install.sh /usr/local/bin/
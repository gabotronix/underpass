#!/bin/bash

# The commands in this script are meant to be ran by root.
# This script is based on or copied from https://github.com/angristan/wireguard-install
# https://raw.githubusercontent.com/angristan/wireguard-install/master/wireguard-install.sh

function isRoot() {
	if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
	fi
}

function checkOS() {
	# Check OS version
	if [[ -e /etc/debian_version ]]; then
		source /etc/os-release
		OS="${ID}" # debian or ubuntu
		if [[ -e /etc/debian_version ]]; then
			if [[ ${ID} == "debian" || ${ID} == "raspbian" ]]; then
				if [[ ${VERSION_ID} -ne 10 ]]; then
					echo "Your version of Debian (${VERSION_ID}) is not supported. Please use Debian 10 Buster"
					exit 1
				fi
			fi
		fi
	elif [[ -e /etc/fedora-release ]]; then
		source /etc/os-release
		OS="${ID}"
	elif [[ -e /etc/centos-release ]]; then
		OS=centos
	else
		echo "Looks like you aren't running this installer on a Debian, Ubuntu, or CentOS system"
		exit 1
	fi
}

function initialCheck() {
	isRoot
	checkOS
}

function installUnderpass() {
	if [[ ${OS} == 'ubuntu' || ${OS} == 'debian' ]]; then
		echo "Wireguard kernel modules are already installed."
	elif [[ ${OS} == 'centos' ]]; then
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

		# install fail2ban
		yum -y install fail2ban
		curl -o /etc/fail2ban/jail.local https://raw.githubusercontent.com/gabotronix/underpass/stage/config/fail2ban/jail-centos7.local
		systemctl start fail2ban
		systemctl enable fail2ban

		# install Docker
		yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
		yum -y install docker-ce docker-ce-cli containerd.io
		systemctl start docker
		systemctl enable docker
	fi

		# install Docker Compose
		# based on a script made by wdullaer:
		# https://gist.githubusercontent.com/wdullaer/f1af16bd7e970389bad3/raw/4a5a72aece57e1deca926894e5919f90350c706d/install.sh
		COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oE "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | sort --version-sort | tail -n 1`
		curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
		chmod +x /usr/local/bin/docker-compose
		curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose

		# install Underpass Docker apps
		docker network create --subnet=172.20.0.0/24 underpass
		cd /home/underpass
		docker-compose up -d

		# create non-root user for Docker
		groupadd -g 1001 dockeru && useradd -u 1001 -g dockeru -G wheel,docker dockeru
		sed -i -e '$a\%dockeru ALL=(ALL) ALL' /etc/sudoers
}

# Check for root, OS...
initialCheck
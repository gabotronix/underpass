#!/bin/bash

# The commands in this script are meant to be ran by root. Docker-Compose cannot run as a sudo user.

# Install EPEL Repo
sudo yum -y install epel-release

# Install Ansible and Git
sudo yum -y install ansible git

# Clone Repo
sudo git clone https://github.com/gabotronix/underpass.git /opt/underpass

# Install Ansible Roles
sudo ansible-galaxy install -r /opt/underpass/ansible/requirements.yml

# Run Ansible Playbook
cd /opt/underpass
sudo ansible-playbook install.yml

# Install Underpass
echo -e "===================================================="
echo -e "Installing Underpass Docker Apps"
echo -e "===================================================="
cd /opt/underpass
DockerNetwork=`sudo docker network ls | grep -c underpass`
if [ $DockerNetwork != 1 ]; then
    sudo docker network create underpass --subnet 172.20.0.0/24
    docker-compose up -d
else
    docker-compose up -d
fi

# Enumerate Web UI's and Ports
UnderpassDir=`ls -l /opt | grep -c underpass`
WhichDockerCompose=`which docker-compose | grep -c /usr`
DockerPS=`sudo docker ps | grep -c mongodb`
function countdown { #https://www.cyberciti.biz/faq/how-to-display-countdown-timer-in-bash-shell-script-running-on-linuxunix/
    local OLD_IFS="${IFS}"
    IFS=":"
    local ARR=( $1 )
    local SECONDS=$((  (ARR[0] * 60 * 60) + (ARR[1] * 60) + ARR[2]  ))
    local START=$(date +%s)
    local END=$((START + SECONDS))
    local CUR=$START

    while [[ $CUR -lt $END ]]
    do
            CUR=$(date +%s)
            LEFT=$((END-CUR))

            printf "\r%02d:%02d:%02d" \
                    $((LEFT/3600)) $(( (LEFT/60)%60)) $((LEFT%60))

            sleep 1
    done
    IFS="${OLD_IFS}"
    echo "        "
}

function webpanels() {
    PublicIP=$(curl -4 ifconfig.co 2>/dev/null)
    echo -e "\n\n===================================================="
    echo -e "Configure Your Underpass Web Panels:"
    echo -e "===================================================="
    echo -e "\nConfigure Portainer @ http://$PublicIP:9000\n"
    echo -e "Configure Pritunl VPN @ https://$PublicIP:4433\n"
    echo -e "View Server Load @ http://$PublicIP:19999\n"
    echo -e "----------------------------------------------------\n"
    echo -e "NOTE: Wireguard will not work unless the server is rebooted. Issue the command below to reboot your server:\n"
    echo -e "reboot\n"
}

if [ $UnderpassDir != 1 ]; then
    echo -e "Installation failed. Please run the installer again as root."
    exit 1
elif [ $WhichDockerCompose != 1 ]; then
    echo -e "Installation failed. Please run the installer again as root."
    exit 1
elif [ $DockerPS != 1 ]; then
    echo -e "Installation failed. Please run the installer again as root."
    exit 1
else
    echo -e "\n\nInitializing Containers..."
    countdown "00:00:30"
    webpanels
fi
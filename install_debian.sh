#!/bin/bash

# The commands in this script are meant to be ran by root.

# Add Ansible Repo and Install Ansible
apt install -y sudo
sudo apt update
sudo apt install -y software-properties-common ansible git

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
    sudo docker-compose up -d
else
    sudo docker-compose up -d
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

if [ $UnderpassDir != 1 ]; then
    echo -e "Installation failed. Please run the installer again."
    exit 1
elif [ $WhichDockerCompose != 1 ]; then
    echo -e "Installation failed. Please run the installer again."
    exit 1
elif [ $DockerPS != 1 ]; then
    echo -e "Installation failed. Please run the installer again."
    exit 1
else
    echo -e "\n\n----------------------------------------------------------------------\n"
    echo -e "This server will now reboot in order to complete the installation.\n"
    echo -e "Please log in again after a minute or so.\n"
    countdown "00:00:10"
    sudo reboot
fi

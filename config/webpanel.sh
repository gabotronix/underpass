#!/bin/bash

function webpanels() {
    PublicIP=$(curl -4 ifconfig.co 2>/dev/null)
    echo -e "\n\n===================================================="
    echo -e "Your Underpass Web Panels:"
    echo -e "===================================================="
    echo -e "\nConfigure Portainer @ http://$PublicIP:9000\n"
    echo -e "Configure Pritunl VPN @ https://$PublicIP:4433\n"
    echo -e "View Server Load @ http://$PublicIP:19999\n"
    echo -e "----------------------------------------------------\n"
}

webpanels

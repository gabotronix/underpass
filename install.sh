#!/bin/bash

# disable ipv6
sed -i -e '$anet.ipv6.conf.all.disable_ipv6 = 1' /etc/sysctl.conf
sed -i -e '$anet.ipv6.conf.default.disable_ipv6 = 1' /etc/sysctl.conf
systemctl restart network

#OpenVPN configuration
sh builds/openvpn/setup.sh
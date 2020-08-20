# Underpass

## A Docker-based server that provides access to a variety of tunneling services.

![laravel-docker-dev-windows](https://user-images.githubusercontent.com/9207205/82763077-731ea700-9e37-11ea-9002-7268133e21a3.png)

***

#### Core Services:
- **VPN**
  1. [OpenVPN](https://hub.docker.com/r/kylemanna/openvpn)
  2. [Wireguard](https://hub.docker.com/r/linuxserver/wireguard)

- **Proxy**
  1. [Shadowsocks](https://hub.docker.com/r/vimagick/shadowsocks/)
  2. [Stunnel](https://hub.docker.com/r/vimagick/stunnel)

- **Secure Shell (SSH)** - [Alpine SSHD (Dropbear)](https://hub.docker.com/r/sjourdan/alpine-sshd)

- **Domain Provider**
  1. [nip.io](https://nip.io/)

#### Secondary Services:
- [OpenVPN Web UI](https://github.com/adamwalach/openvpn-web-ui)
- TLS/SSL Provider - [Let's Encrypt](https://letsencrypt.org/)
- Docker Web UI - [Portainer](https://hub.docker.com/r/portainer/portainer)
- Reverse Proxy - [Nginx Proxy Manager](https://hub.docker.com/r/jlesage/nginx-proxy-manager)
- Web Portal/Organizer - [Heimdall](https://hub.docker.com/r/linuxserver/heimdall)
- Container Monitoring - [Prometheus](https://hub.docker.com/r/prom/prometheus)
- Container Monitoring Frontend - [Grafana](https://hub.docker.com/r/grafana/grafana)
- Server Monitoring
  1. [Netdata](https://hub.docker.com/r/netdata/netdata)
  2. htop
  3. glances

#### Host Services:
- Firewall - iptables
- Intrusion Prevention - fail2ban
- Desktop UI - [Rdesktop] (https://hub.docker.com/r/linuxserver/rdesktop)
- Source Control Management - git

***

_Credits:_

- [daybreakersx](https://github.com/daybreakersx)

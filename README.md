# Underpass

## A Docker-based personal tunneling solution.

![laravel-docker-dev-windows](https://user-images.githubusercontent.com/9207205/82763077-731ea700-9e37-11ea-9002-7268133e21a3.png)

***

#### Core Services:
- **VPN** - [Pritunl](https://hub.docker.com/r/jippi/pritunl)

- **Proxy** - [Shadowsocks](https://github.com/EasyPi/docker-shadowsocks-libev)

- **SSH Server** - [Dropbear](https://matt.ucc.asn.au/dropbear/dropbear.html)

#### Secondary Services:
- Docker Web UI - [Portainer](https://hub.docker.com/r/portainer/portainer)
- Reverse Proxy - [Nginx Proxy Manager](https://hub.docker.com/r/jlesage/nginx-proxy-manager)
- Web Portal/Organizer - [Heimdall](https://hub.docker.com/r/linuxserver/heimdall)
- Container Monitoring - [Prometheus](https://hub.docker.com/r/prom/prometheus)
- Container Monitoring Frontend - [Grafana](https://hub.docker.com/r/grafana/grafana)
- Server Monitoring
  1. htop
  2. glances

#### Host Services:
- Server Manager - [Cockpit](https://cockpit-project.org/)
- SSH Server - Dropbear
- Firewall - iptables
- Intrusion Prevention - fail2ban
- Source Code Management - Git

***

### Requirements:
1. Linux VPS with at least 2GB RAM:
  - Digital Ocean Droplet (USD10/mo)
  - AWS EC2 t2.small
  - GCP Compute Engine e2-small
  - Azure Linux Virtual Machine B1MS

2. Docker and Docker Compose

***

_References:_

- [daybreakersx](https://github.com/daybreakersx)

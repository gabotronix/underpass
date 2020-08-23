# Underpass

## A Docker-based server that provides access to a variety of tunneling services.

![laravel-docker-dev-windows](https://user-images.githubusercontent.com/9207205/82763077-731ea700-9e37-11ea-9002-7268133e21a3.png)

***

#### Core Services:
- **VPN** - [Pritunl](https://hub.docker.com/r/jippi/pritunl)

- **Proxy** - [Shadowsocks](https://github.com/EasyPi/docker-shadowsocks-libev)

- **Secure Shell (SSH)** - [Alpine SSHD](https://hub.docker.com/r/sjourdan/alpine-sshd)

#### Secondary Services:
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
- Desktop UI - [Rdesktop](https://hub.docker.com/r/linuxserver/rdesktop)
- Source Control Management - git

***

### Requirements:
1. Linux VPS with at least 2GB RAM:
  - Digital Ocean Droplet (USD10/mo)
  - AWS EC2 t2.small
  - GCP Compute Engine e2-small
  - Azure Linux Virtual Machine B1MS

2. Docker and Docker Compose
  - How to install docker on 

***

_References:_

- [daybreakersx](https://github.com/daybreakersx)
- [vmagick/dockerfiles/openvpn](https://github.com/vimagick/dockerfiles/tree/master/openvpn)
- [jeromelaliagg](https://www.youtube.com/user/Jeromelaliag)

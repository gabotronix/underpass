# Underpass

## A collection of Docker-based tunneling services for personal use.

![underpass_banner](https://user-images.githubusercontent.com/9207205/90979447-b0561a80-e587-11ea-951f-efcaaed63654.png)

***

#### Core Services:
- **VPN** - [Pritunl (Docker)](https://hub.docker.com/r/jippi/pritunl)

- **Proxies**
  1. [Shadowsocks (Docker)](https://github.com/EasyPi/docker-shadowsocks-libev)
  2. [Privoxy (Docker)](https://hub.docker.com/r/splazit/privoxy-alpine)
  2. [Squid (Docker)](https://hub.docker.com/r/b4tman/squid)

- **SSH Server** - [Dropbear (Host)](https://matt.ucc.asn.au/dropbear/dropbear.html)

#### Secondary Services:
- Docker Web UI - [Portainer](https://hub.docker.com/r/portainer/portainer)
- Reverse Proxy - [Nginx Proxy Manager](https://hub.docker.com/r/jlesage/nginx-proxy-manager)
- Web Portal/Organizer - [Heimdall](https://hub.docker.com/r/linuxserver/heimdall)
- File Hosting - [ProjectSend](https://hub.docker.com/r/linuxserver/projectsend)
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
1. Ubuntu 18.04 x64 or CentOS 7 x64

2. VPS with at least 2GB RAM:
  - Digital Ocean Droplet (USD10/mo)
  - AWS EC2 t2.small
  - GCP Compute Engine e2-small
  - Azure Linux Virtual Machine B1MS

3. Docker and Docker Compose

***

### Installation:
- Refer to [docs](https://github.com/gabotronix/underpass-docs)

***

_References:_

- [daybreakersx](https://github.com/daybreakersx)
- [HTTP Proxy Injector](https://sourceforge.net/projects/httpproxyinjector/)

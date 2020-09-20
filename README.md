# Underpass

## A collection of personal tunneling services based on Docker containers.

![underpass_banner_2](https://user-images.githubusercontent.com/9207205/92270351-7afee480-ef18-11ea-815c-6e719869f848.png)

***

### Docker Apps:
- **VPN**
  - Pritunl with IPv6 support from [goofball222](https://hub.docker.com/r/goofball222/pritunl)
  - Wireguard from [linuxserver](https://hub.docker.com/r/linuxserver/wireguard)

- **Proxies**
  - Shadowsocks from [gists](https://hub.docker.com/r/gists/shadowsocks-libev)
  - Dante SOCKS from [wernight](https://hub.docker.com/r/wernight/dante)
  - Squid from [b4tman](https://hub.docker.com/r/b4tman/squid)

- **Secure Shell** - OpenSSH-Server from [yuriyvlasov](https://hub.docker.com/r/yuriyvlasov/openssh-server)

### Other Docker Apps:
  - Container UI: [Portainer-CE](https://hub.docker.com/r/portainer/portainer)
  - App Dashboard: Heimdall from [linuxserver](https://hub.docker.com/r/linuxserver/heimdall)
    - System Monitoring: [Netdata](https://hub.docker.com/r/netdata/netdata)
  - Pritunl Data Store: [MongoDB](https://hub.docker.com/_/mongo)

### Optional Docker Apps:
  - File Hosting: Droppy from [silverwind](https://github.com/silverwind/droppy)
  - MongoDB UI: [mongo-express](https://hub.docker.com/_/mongo-express)
  - Desktop UI: rdesktop from [linuxserver](https://hub.docker.com/r/linuxserver/rdesktop)
  - IPSec/L2TP VPN: SoftEther from [cenk1cenk2](https://hub.docker.com/r/cenk1cenk2/softether-vpnsrv)

***

### Requirements:
1. Ubuntu 18.04, CentOS 7 - 64-bit

2. Docker and Docker Compose (versions starting v19.03 and v1.26 respectively)

3. VPS with at least 2GB RAM:
  - Hetzner Cloud CX11 (EUR 2.49/mo) - _tested_
  - OVH Public Cloud Sandbox s1-2 (USD 3.50/mo)
  - Digital Ocean Droplet (USD 10/mo) - _tested_
  - AWS EC2 t2.small
  - GCP Compute Engine e2-small
  - Azure Linux Virtual Machine B1MS

***

### Installation and Initial Configuration:
Log in to SSH as root:

1. On CentOS 7: `bash <(curl -s https://raw.githubusercontent.com/gabotronix/underpass/install_centos7.sh)`
   On Ubuntu 18.04: `bash <(curl -s https://raw.githubusercontent.com/gabotronix/underpass/install_ubuntu.sh)`

2. Set Web Access Credentials:
  - Portainer: http://ip_of_server:9000
    - set an admin password (at least 8 characters)
  - Pritunl: https://ip_of_server:4433
    - The page will show some kind of a Privacy Reminder due to Pritunl using a self-signed certificate. Proceed anyway.
    - Pritunl will ask you to issue a command from SSH in order to retrieve the admin password. Issue the commmand below:
    - `docker exec pritunl pritunl default-password`

3. Set Heimdall _admin_ Password:
  - Heimdall: http://ip_of_server:85

4. Create Users for Squid, Dante SOCKS, and OpenSSH:

***

_References:_

- [daybreakersx](https://github.com/daybreakersx)
- [HTTP Proxy Injector](https://github.com/a-dev1412/a-dev1412.github.io)
- docker-compose installation: [wdullaer](https://gist.githubusercontent.com/wdullaer/f1af16bd7e970389bad3/raw/4a5a72aece57e1deca926894e5919f90350c706d/install.sh)

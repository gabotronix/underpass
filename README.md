# Underpass

## A collection of personal tunneling services based on Docker containers.

![underpass_banner_2](https://user-images.githubusercontent.com/9207205/92270351-7afee480-ef18-11ea-815c-6e719869f848.png)

***

### Docker Apps:
- **VPN**
  - Pritunl with Wireguard from [goofball222](https://hub.docker.com/r/goofball222/pritunl)
  - Wireguard from [linuxserver](https://hub.docker.com/r/linuxserver/wireguard)

- **Proxies**
  1. Shadowsocks from [gists](https://hub.docker.com/r/gists/shadowsocks-libev)
  2. Privoxy from [splazit](https://hub.docker.com/r/splazit/privoxy-alpine)
  3. Squid from [b4tman](https://hub.docker.com/r/b4tman/squid)

- **Secure Shell** - OpenSSH-Server from [yuriyvlasov](https://hub.docker.com/r/yuriyvlasov/openssh-server)

### Other Docker Apps:
  - Container UI: [Portainer-CE](https://hub.docker.com/r/portainer/portainer)
  - App Dashboard: Heimdall from [linuxserver](https://hub.docker.com/r/linuxserver/heimdall)
  - File Hosting: Droppy from [silverwind](https://github.com/silverwind/droppy)
  - System Monitoring: [Netdata](https://hub.docker.com/r/netdata/netdata)
  - Pritunl Data Store: [MongoDB](https://hub.docker.com/_/mongo)

### Optional Docker Apps:
  - MongoDB UI: [mongo-express](https://hub.docker.com/_/mongo-express)
  - Desktop UI: rdesktop from [linuxserver](https://hub.docker.com/r/linuxserver/rdesktop)
  - IPSec/L2TP VPN: SoftEther from [cenk1cenk2](https://hub.docker.com/r/cenk1cenk2/softether-vpnsrv)

***

### Requirements:
1. Ubuntu 20.04 LTS x64 or CentOS 7 x64

2. Docker v19.03+ and Docker Compose v1.26+

3. VPS with at least 2GB RAM:
  - Hetzner Cloud CX11 (EUR 2.49/mo) - _tested_
  - OVH Public Cloud Sandbox s1-2 (USD 3.50/mo)
  - Digital Ocean Droplet (USD 10/mo) - _tested_
  - AWS EC2 t2.small
  - GCP Compute Engine e2-small
  - Azure Linux Virtual Machine B1MS

4. Wireguard Kernel Modules: [CentOS 7](https://www.wireguard.com/install/#centos-7-module-plus-module-kmod-module-dkms-tools), Ubuntu 20.04 (built-in)

***

### Installation:
- Refer to [docs](https://github.com/gabotronix/underpass-docs)

***

_References:_

- [daybreakersx](https://github.com/daybreakersx)
- [HTTP Proxy Injector](https://sourceforge.net/projects/httpproxyinjector/)
- docker-compose installation: [wdullaer](https://gist.githubusercontent.com/wdullaer/f1af16bd7e970389bad3/raw/4a5a72aece57e1deca926894e5919f90350c706d/install.sh)

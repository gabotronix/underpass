# Underpass

## A collection of personal tunneling services based on Docker containers.

![underpass_banner_2](https://user-images.githubusercontent.com/9207205/92270351-7afee480-ef18-11ea-815c-6e719869f848.png)

***

### Docker Apps:
- **VPN**
  - Pritunl with IPv6 support from [goofball222](https://hub.docker.com/r/goofball222/pritunl)
  - Wireguard from [linuxserver](https://hub.docker.com/r/linuxserver/wireguard)

- **Proxy**
  - Shadowsocks from [gists](https://hub.docker.com/r/gists/shadowsocks-libev)
  - Dante SOCKS from [wernight](https://hub.docker.com/r/wernight/dante)
  - Squid from [b4tman](https://hub.docker.com/r/b4tman/squid)

- **Secure Shell**
  - OpenSSH-Server from [yuriyvlasov](https://hub.docker.com/r/yuriyvlasov/openssh-server)

***

### Companion Apps:
  - Container UI: [Portainer-CE](https://hub.docker.com/r/portainer/portainer)
  - System Monitoring: [Netdata](https://hub.docker.com/r/netdata/netdata)
  - Pritunl Data Store: [MongoDB](https://hub.docker.com/_/mongo)

***

### Optional Apps:
  - App Dashboard: Heimdall from [linuxserver](https://hub.docker.com/r/linuxserver/heimdall)
  - Reverse Proxy: Nginx Proxy Manager from [jlesage](https://hub.docker.com/r/jlesage/nginx-proxy-manager)
  - File Hosting: Droppy from [silverwind](https://github.com/silverwind/droppy)
  - MongoDB UI: [mongo-express](https://hub.docker.com/_/mongo-express)
  - Desktop UI: rdesktop from [linuxserver](https://hub.docker.com/r/linuxserver/rdesktop)
  - IPSec/L2TP VPN: SoftEther from [cenk1cenk2](https://hub.docker.com/r/cenk1cenk2/softether-vpnsrv)

***

### Requirements:
1. Ubuntu 18.04 or CentOS 7, 64-bit

2. VPS with at least 2GB RAM, fresh install

***

### Installation
Log in to SSH as root and issue the command below:

#### Install on CentOS 7:
```
bash <(curl -s https://raw.githubusercontent.com/gabotronix/underpass/master/install_centos7.sh)
```

#### Install on Ubuntu 18.04:
```
bash <(curl -s https://raw.githubusercontent.com/gabotronix/underpass/master/install_ubuntu.sh)
```

That's it! Next, proceed to the Initial Configuration section.

***

#### Note
_Installing on an existing system is not recommended because some containers require opening ports from the Docker host via firewalld. Other containers may also cause port conflicts._

_If you're already familiar with Docker, or you just want to install these apps on your existing system, you may do so at your own risk by installing Docker and Docker Compose. Refer to the [Docker](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/) docs for more info._

_Once you have Docker and Docker Compose installed, clone this repository and run docker-compose:_
```
git clone https://github.com/gabotronix/underpass.git /opt/underpass
cd /opt/underpass
docker network create underpass --subnet 172.20.0.0/24
docker-compose up -d
```
_Ports to Open from the Docker host:_
  - _3128/tcp for the Squid default port_
  - _1080/tcp for Dante SOCKS default port_

***

### Initial Configuration

**Configure Immediately**
- [Portainer](https://github.com/gabotronix/underpass-docs/blob/draft/portainer.md)
- [Pritunl](https://github.com/gabotronix/underpass-docs/blob/draft/pritunl.md)
- [Shadowsocks](https://github.com/gabotronix/underpass-docs/blob/draft/shadowsocks.md)

**Configure Next**
- [Dante SOCKS](https://github.com/gabotronix/underpass-docs/blob/draft/dante.md)
- [Squid](https://github.com/gabotronix/underpass-docs/blob/draft/squid.md)
- [OpenSSH-Server](https://github.com/gabotronix/underpass-docs/blob/draft/openssh.md)

**Configure Later**
- [Wireguard](https://github.com/gabotronix/underpass-docs/blob/draft/wireguard.md)
- [Netdata](https://github.com/gabotronix/underpass-docs/blob/draft/netdata.md)

**Optional Services Configuration**
- [Nginx Proxy Manager](https://github.com/gabotronix/underpass-docs/blob/draft/nginx-proxy.md)
- [SoftEther](https://github.com/gabotronix/underpass-docs/blob/draft/softether.md)

***

#### Default Port Assignments

Port assignments are defined in `/opt/underpass/.env`

You can change the ports for each service by editing the `.env` file.

Except for Squid and Dante, any change in the `.env` file requires a container restart. For instance, if you changed `SSH_PORT` in `.env` from 2222 to 2233, you'll have to recreate the container for SSH:
```
cd /opt/underpass
docker-compose up -d --force-recreate ssh
```

#### Container Names List
- dante
- mongodb
- netdata
- portainer
- pritunl
- shadowsocks
- squid
- ssh
- wireguard

Additional reading: [Identifying Container Names and Published Ports](https://github.com/gabotronix/underpass-docs/blob/draft/containers.md)

#### Default Ports
```
PRITUNL_TCP=1194
PRITUNL_UDP=1194
WIREGUARD_PORT_UDP=51820
SHADOWSOCKS_TCP=8388
SHADOWSOCKS_UDP=8388
SSH_PORT=2222

# Web Panels:
Pritunl = 4433
Portainer = 9000
Netdata = 19999
```

***

### Installing Optional Services

There are additional apps that come with Underpass. Please note that installing these apps will increase RAM and disk usage. A server with 3-4GB RAM is recommended. A VPS with 2GB RAM already consumes around 70% of the total capacity when all the apps are installed.

#### Container Names List for Additional Services
  - droppy
  - heimdall
  - mongo-express
  - netdata
  - nginx-proxy-manager
  - rdesktop
  - softether

To install these services, go to the `optional_services` folder and issue the docker-compose command with the service name. For example:
```
cd /opt/underpass/optional_services
docker-compose up -d softether
```

The `optional_services` folder also comes with its own `.env` file. You can change ports as desired, but make sure to recreate the container afterwards:
```
cd /opt/underpass/optional_services
docker-compose up -d --force-recreate softether
```

#### Default Ports for Optional Services
```
RDESKTOP_PORT=3389
SOFTETHER_PORT1=1443
SOFTETHER_PORT2=992
SOFTETHER_PORT3=5555
SOFTETHER_OPENVPN_UDP=1196
SOFTETHER_OPENVPN_TCP=1196
SOFTETHER_IPSEC_PORT1_UDP=500
SOFTETHER_IPSEC_PORT2_UDP=4500
SOFTETHER_IPSEC_PORT3=1701

# Web Panels:
Droppy = 8989
Heimdall = 85
Mongo-Express = 8081
Nginx Proxy Manager = 8181
```

***

#### Mongo-Express

If you wish to install `mongo-express`, please change the username and password in `/opt/underpass/optional_services/.env` beforehand.
```
MONGO_EXPRESS_USER=xxxxxxx
MONGO_EXPRESS_PASSWORD=xxxxxxxxxx
```

Then, install `mongo-express`
```
cd /opt/underpass/optional_services
docker-compose up -d mongo-express
```

***

#### Post-Installation: sudo User For Your Docker Host

It's highly advised to log in to your server (aka Docker host) via a non-privileged user. You'll then only need to invoke root permissions by prepending your commands with `sudo`.

For example, we'll create a user named `userpass` and give it sudo permissions. On Ubuntu:
```
adduser userpass
```

On CentOS:
```
useradd userpass
```

Input your desired password if you're prompted for one. Otherwise:
```
passwd userpass
```

Input your desired password.

You'll then have to add `userpass` to the Docker group:
```
usermod -a -G wheel userpass
```

Next, add `userpass` to the `sudoers` file:
```
sed -i -e '$auserpass ALL=(ALL) NOPASSWD\: ALL' /etc/sudoers
```

_Note that `'$a` will add `userpass` to the last line of `/etc/sudoers`_

Log out or disconnect from your SSH session in order to reload the new permissions.

The next time you log in to your Docker host, use `userpass` as the login.

**Add Your User to the Docker Group**

As in our example, login as `userpass` and add `userpass` to the `docker` group:
```
sudo usermod -aG docker $USER
```

Finally, logout of SSH and log in again. You should now be able to issue `docker` and `docker-compose` commands as `userpass`.

***

_References:_

- [daybreakersx](https://github.com/daybreakersx)
- [angristan](https://raw.githubusercontent.com/angristan/wireguard-install/master/wireguard-install.sh)
- [HTTP Proxy Injector](https://github.com/a-dev1412/a-dev1412.github.io)

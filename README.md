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

- **Secure Shell** - OpenSSH-Server from [yuriyvlasov](https://hub.docker.com/r/yuriyvlasov/openssh-server)

***

### Companion Apps:
  - Container UI: [Portainer-CE](https://hub.docker.com/r/portainer/portainer)
  - Pritunl Data Store: [MongoDB](https://hub.docker.com/_/mongo)

***

### Optional Apps:
  - App Dashboard: Heimdall from [linuxserver](https://hub.docker.com/r/linuxserver/heimdall)
  - System Monitoring: [Netdata](https://hub.docker.com/r/netdata/netdata)
  - File Hosting: Droppy from [silverwind](https://github.com/silverwind/droppy)
  - MongoDB UI: [mongo-express](https://hub.docker.com/_/mongo-express)
  - Desktop UI: rdesktop from [linuxserver](https://hub.docker.com/r/linuxserver/rdesktop)
  - IPSec/L2TP VPN: SoftEther from [cenk1cenk2](https://hub.docker.com/r/cenk1cenk2/softether-vpnsrv)

***

### Requirements:
1. Ubuntu 18.04 or CentOS 7 - 64-bit

2. Docker and Docker Compose (tested on versions v19.03 and v1.26 respectively)

3. Ansible (tested on version 2.9.10)

4. VPS with at least 1GB RAM, fresh install

***

### Installation
Log in to SSH as root and issue the command below:

**Install on CentOS 7:**
```
bash <(curl -s https://raw.githubusercontent.com/gabotronix/underpass/install_centos7.sh)
```

**Install on Ubuntu 18.04:**
```
bash <(curl -s https://raw.githubusercontent.com/gabotronix/underpass/install_ubuntu.sh)`
```

That's it! Next, proceed to the Initial Configuration section.

***

_Installation Issues_

_Digital Ocean - Ubuntu 18.04:_
_If you get a pop-up message about a new version of /boot/grub/menu.lst, simply accept the default selection and continue with the installation._
`keep the local version currently installed`

***

#### Note
_Installing on an existing system is not recommended because some containers require opening ports from the Docker host via firewalld. Other containers may also cause port conflicts._

_If you're already familiar with Docker, or you just want to install these apps on your existing system, you may do so at your own risk by installing Docker and Docker Compose. Refer to the [Docker](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/) docs for more info._

_Once you have Docker and Docker Compose installed, clone this repository and run docker-compose. For example:_
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

**Portainer:** _http://ip_of_server:9000_

![portainer_initial_setup](https://user-images.githubusercontent.com/9207205/93722499-d47a3b00-fbc9-11ea-8754-ddc698e6dd48.png)

Set an admin password (please set an extremely strong [password](https://www.lastpass.com/password-generator))

***

**Pritunl:** _https://ip_of_server:4433_

![pritunl_initial_setup](https://user-images.githubusercontent.com/9207205/93722506-e065fd00-fbc9-11ea-9e2f-8c249533c0d7.png)

The page will show a notification like _Your connection is not private_. This is due to Pritunl using a self-signed certificate. Proceed anyway.

Pritunl will then ask you to issue a command from SSH in order to retrieve the admin password. Issue the command below:
```
docker exec pritunl pritunl default-password
```

***

**Pritunl Settings:**

Once logged in to Pritunl, you will be asked to set a new admin username and password.

The first thing to do after setting the admin user is to add an `Organization` in `Users > Add Organization`. An `Organization` is simply a name that you want for your group.

_Group_ refers to the VPN servers that you will be creating later on. Pritunl allows you to create multiple TCP or UDP OpenVPN servers. You are only limited by your server resources.

Before you can start a VPN server, you'll be required to attach an `Organization` to it.

![pritunl_organization](https://user-images.githubusercontent.com/9207205/93812435-30a19580-fc84-11ea-9fa9-d9f59ac27aea.png)

**Adding an OpenVPN Server**

Add an OpenVPN server from `Servers > Add Server`. You'll then need to fill up the server settings. A tooltip will appear when you hover your mouse over an option.

![pritunl_server_settings](https://user-images.githubusercontent.com/9207205/93813071-1ddb9080-fc85-11ea-9cb1-2d6f8d574fe7.png)

_Note:_

`Port`: refers to the port that was defined from `PRITUNL_TCP` and `PRITUNL_UDP` in `/opt/underpass/.env`. It's `1194` by default.

_Please also note that `Enable WireGuard` is not supported by Underpass_
  
***

**Change Shadowsocks Password**

The Shadowsocks password is defined in `/opt/underpass/.env`

Please change the Shadowsocks password immediately in order to avoid unauthorized access. You can do so by editing `.env` using your preferred text editor and changing the value of `SHADOWSOCKS_PASSWORD=`

Once done, restart the container:
```
cd /opt/underpass
docker-compose restart shadowsocks
```

***

**Create Users for Squid:**

The **Squid configuration** files are located at `/opt/underpass/config/squid/`

In the _squid_ folder, edit the `users` file using your preferred text editor and use a [_passwd-generator_](https://hostingcanada.org/htpasswd-generator/) to create your own user-password combination. Refer to the `users` file in `/opt/underpass/squid/` for more info.

Any changes to the squid configuration will require you to recreate the container. Issue the commands below from SSH in order to do that:
```
cd /opt/underpass/
docker-compose up -d --force-recreate squid
```

**Changing the Squid Port**

You can change the port for Squid by changing the `http_port` number from `/opt/underpass/config/squid.conf`
```
# Squid normally listens to port 3128
http_port 3128
```

Recreate the container afterwards:
```
cd /opt/underpass
docker-compose up -d --force-recreate squid
```

You will then have to open the new port from the Docker host. For example, if you changed the Squid port from 3128 to 3888, issue these commands as root from SSH:
```
firewall-cmd --remove-service=squid --permanent
firewall-cmd --zone=public --add-port=3888/tcp --permanent
firewall-cmd --reload
```

***

**Create Users for Dante SOCKS:**

The **Dante SOCKS configuration** is located at `/opt/underpass/config/dante/sockd.conf`

By default, it requires authentication to be able to successfully connect.

If you want to risk opening your SOCKS5 service to the public, comment out the line in `sockd.conf` that's inside the `socks pass {}` directive: 
```
#socksmethod: username
```

To create a SOCKS5 user, issue the command below from SSH:
```
docker exec -it dante adduser -s /sbin/nologin username
```
Where: `username` is the name of the user that you want to add. You will then be asked to input a password.

User creation can also be done from Portainer:

![dante_portainer_console](https://user-images.githubusercontent.com/9207205/93722750-9b42ca80-fbcb-11ea-8743-198959cbc53f.png)

User records will persist even if the container is destroyed/deleted/removed.

**Changing the SOCKS5 Port**

You can change the port for Dante by changing the line, `internal: 0.0.0.0 port = 1080` in `/opt/underpass/config/dante/sockd.conf`

Recreate the container afterwards:
```
cd /opt/underpass
docker-compose up -d --force-recreate dante
```

You will then have to open the new port from the Docker host. For example, if you changed the SOCKS5 port from 1080 to 1090, issue these commands from SSH as root:
```
firewall-cmd --remove-port=1080/tcp --permanent
firewall-cmd --zone=public --add-port=1090/tcp --permanent
firewall-cmd --reload
```

***

**Create Users for OpenSSH:**

Users for OpenSSH are created via a YAML file. The file is located at `/opt/underpass/config/openssh/config.yml`

Instructions on how to create a user and generate a password are already in `config.yml`

***

**Wireguard Usage:**

By default, Wireguard is configured to have 1 peer that can be used by multiple users and devices at the same time. If you wish to configure more than one peer, edit `WIREGUARD_PEERS=1` from `/opt/underpass/.env` and change the number as desired. Restart the container afterwards:
```
cd /opt/underpass
docker-compose restart wireguard
```

To retrieve the peer configuration, issue this command from SSH:
```
docker exec wireguard cat /config/peer1/peer1.conf
```

`peer1` refers to the first peer that was set up by Wireguard. If you changed `WIREGUARD_PEERS` to more than 1, then you'll also be able to retrieve the configuration for `peer2`, `peer3`, and so on by changing the command above to the corresponding peer number.

You can then copy-paste the config in your Wireguard client:
```
[Interface]
Address = 10.13.13.2
PrivateKey = 0NUF5UY4NnqkrXIiyxXxf+eWQSMMfzsSnDiEXxX/X1X=
ListenPort = 51820
DNS = 8.8.8.8

[Peer]
PublicKey = 2sv1xXxpXDn8Fmyhb6QNQxxXcl3PLmMj18qXxXNlnxx=
Endpoint = 1xx.2xxx.1xx.1xx:51820
AllowedIPs = 0.0.0.0/0, ::/0
```
You can also retrieve the peer's QR Code from the Wireguard server so that you can easily pair it with your mobile device's Wireguard client. From SSH, issue the command below:
```
docker exec wireguard /app/show-peer 1
```

![wireguard_server_show_qr](https://user-images.githubusercontent.com/9207205/93795143-9170a400-fc6b-11ea-8db0-ebfdda1084ba.png)

***

**Default Port Assignments**

Port assignments are defined in `/opt/underpass/.env`

You can change the ports for each service by editing the `.env` file. Restart the container afterwards.

For example, if you changed `SSH_PORT` in `.env` to 2223 from 2222, you'll have to restart the container:
```
cd /opt/underpass
docker-compose restart ssh
```

**Default Ports**
```
PRITUNL_TCP=1194
PRITUNL_UDP=1194
WIREGUARD_PORT=51820
SHADOWSOCKS_TCP=8388
SHADOWSOCKS_UDP=8388
SSH_PORT=2222

# Web Panels:
Pritunl = 4433
Portainer = 9000
```

***

**Identifying Container Names and Published Ports**

Container names are used to stop, restart, or remove containers. You can view the names, as well as their assigned ports in Portainer:

![portainer_container_list](https://user-images.githubusercontent.com/9207205/93723394-cda2f680-fbd0-11ea-9fbb-2c927366f9ba.png)

You can also issue the command below from SSH:
```
docker ps
```

Docker ports have the format, `2222:22`

The number before the _colon (:)_ represents the port that will be exposed to the public. That is the port to use in your SSH, VPN, or Proxy clients. The number after the _colon_ is used by Docker internally.

***

**Installing Optional Services**

There are additional apps that come with Underpass. Please note that installing these apps will increase RAM and disk usage. A server with at least 2GB RAM is recommended.

_List of Additional Services_
  - droppy
  - heimdall
  - mongo-express
  - netdata
  - rdesktop
  - softether

To install these services, go to the `optional_services` folder and issue the docker-compose command with the service name. For example:
```
cd /opt/underpass/optional_services
docker-compose up -d softether
```

The `optional_services` folder also comes with its own `.env` file. You can change ports as desired, but make sure to restart the container afterwards:
```
cd /opt/underpass/optional_services
docker-compose restart softether
```

**Default Ports for Optional Services**
```
RDESKTOP_PORT=3389
SOFTETHER_PORT1=1443
SOFTETHER_PORT2=992
SOFTETHER_PORT3=5555
SOFTETHER_OPENVPN_UDP=1196
SOFTETHER_OPENVPN_TCP=1196
SOFTETHER_IPSEC_PORT1=500
SOFTETHER_IPSEC_PORT2=4500
SOFTETHER_IPSEC_PORT3=1701

# Web Panels:
Droppy = 8989
Heimdall = 85
Mongo-Express: 8081
Net Data = 19999
```

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

_References:_

- [daybreakersx](https://github.com/daybreakersx)
- [angristan](https://raw.githubusercontent.com/angristan/wireguard-install/master/wireguard-install.sh)
- [HTTP Proxy Injector](https://github.com/a-dev1412/a-dev1412.github.io)

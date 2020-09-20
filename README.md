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

### Companion Docker Apps:
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
1. Ubuntu 18.04 or CentOS 7 - 64-bit

2. Docker and Docker Compose (beginning at versions v19.03 and v1.26 respectively)

3. VPS with at least 1GB RAM, clean install

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

_Installing on an existing system is not recommended because some containers require opening ports from the Docker host via firewalld. The containers may also cause port assignment conflicts._

_If you still want to install these apps on your existing system, you may do so at your own risk by installing Docker and Docker Compose. Refer to the [Docker](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/) docs for more info._

_Once you have Docker and Docker Compose installed, clone this repository and run docker-compose. For example:_
```
git clone https://github.com/gabotronix/underpass.git /opt/underpass
cd /opt/underpass
docker network create underpass --subnet 172.20.0.0/24
docker-compose up -d
```

***

### Initial Configuration

1. **Set Web Access Credentials:**
  - Portainer: _http://ip_of_server:9000_
    - set an admin password (please set a strong password)
  - Pritunl: _https://ip_of_server:4433_
    - The page will show some kind of a Privacy error due to Pritunl using a self-signed certificate. Proceed anyway.
    - Pritunl will ask you to issue a command from SSH in order to retrieve the admin password. Issue the commmand below:
    - `docker exec pritunl pritunl default-password`
    - Once inside, you will be asked to set a new admin username and password.

2. Set Heimdall _admin_ Password: _http://ip_of_server:85/users_

2. Create Users for Squid, Dante SOCKS, and OpenSSH:
  - The **Squid configuration** is located at `/opt/underpass/config/squid/`
  - In the _squid_ folder, edit the `users` file with your preferred text editor and use the [_passwd-generator_](https://hostingcanada.org/htpasswd-generator/) link to create your own user-password combination.
  - Any changes in the squid folder will require you to recreate the container in SSH, like so:
  - ```cd /opt/underpass/
       docker-compose up -d --force-recreate squid
    ```

  - The **Dante SOCKS configuration** is located at `/opt/underpass/config/dante/sockd.conf`
  - By default, it requires authentication to connect.
  - If you want to open your server to the public, comment out the line in sockd.conf that's inside the `socks pass {}` directive, like so:
  - `#socksmethod: username`

***

_References:_

- [daybreakersx](https://github.com/daybreakersx)
- [HTTP Proxy Injector](https://github.com/a-dev1412/a-dev1412.github.io)

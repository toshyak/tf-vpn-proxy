#!/bin/bash

# Digiatal ocean monitoring tools
curl -sSL https://repos.insights.digitalocean.com/install.sh | sudo bash

#Enable ports in firewall for proxy and VPN
ufw allow 500/udp
ufw allow 4500/udp
ufw allow ${proxy_port}/tcp

#SOCKS5 proxy https://github.com/serjs/socks5-server
docker pull serjs/go-socks5-proxy
docker run -d --name socks5-proxy -p ${proxy_port}:1080 -e PROXY_USER=${proxy_user} -e PROXY_PASSWORD=${proxy_password} serjs/go-socks5-proxy

#IpSec VPN https://github.com/hwdsl2/docker-ipsec-vpn-server
sudo modprobe af_key
sudo echo "VPN_IPSEC_PSK=${vpn_ipsec_psk}
VPN_USER=${vpn_user}
VPN_PASSWORD=${vpn_password}" > /vpn.env
docker pull hwdsl2/ipsec-vpn-server
docker run \
    --name ipsec-vpn-server \
    --env-file /vpn.env \
    --restart=always \
    -p 500:500/udp \
    -p 4500:4500/udp \
    -v /lib/modules:/lib/modules:ro \
    -d --privileged \
    hwdsl2/ipsec-vpn-server

#store VPN credentials
docker cp ipsec-vpn-server:/opt/src/vpn-gen.env ./
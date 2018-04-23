# Terraform configuration for SOCKS5 proxy and IPsec VPN server in DigitalOcean

Creates droplet in [DigitalOcean](https://digitalocean.com) with SOCKS5 proxy server and IPsec VPN server. Based on [SOCKS5 server](https://github.com/serjs/socks5-server) and [IPsec VPN server](https://github.com/hwdsl2/docker-ipsec-vpn-server) Docker images.

## Usage
---
Create file "vars.tfvars" with terraform input variables([example](vars.tfvars.example)). Input variables [description](#input-variables).

After, in cloned repository:
```bash
terraform init
terraform apply -var-file="vars.tfvars"
```

## Next steps
---
[Configure IPsec/L2TP VPN Clients](https://github.com/hwdsl2/setup-ipsec-vpn/blob/master/docs/clients.md)

## Important notes
---
Due to an IPsec/L2TP limitation and an Libreswan [issue](https://github.com/libreswan/libreswan/issues/166), it is not currently possible to connect multiple devices simultaneously from behind the same NAT (e.g. home router). More info [here](https://github.com/hwdsl2/docker-ipsec-vpn-server#important-notes).

## Input variables
---
* `do_token` - DigitalOcean access token. https://developers.digitalocean.com/documentation/v2/#authentication

* `droplet_name` - Droplet name in DigitalOcean

* `region` - A datacenter where droplet will be depoyed. https://developers.digitalocean.com/documentation/v2/#regions

* `ssh_key_path` - Absolute path to ssh key to install in droplet

* `proxy_user` - Username to authenticate in SOCKS5 proxy

* `proxy_password` - Password to authenticate in SOCKS5 proxy

* `proxy_port` - Network port for SOCKS5 proxy

* `vpn_user` - VPN username. DO NOT use these special characters within values: \\ \" '

* `vpn_password` - VPN password. DO NOT use these special characters within values: \\ \" '

* `vpn_ipsec_psk` - IPsec pre-shared key. DO NOT use these special characters within values: \\ \" '

variable "do_token" {
  description = "DigitalOcean access token. https://developers.digitalocean.com/documentation/v2/#authentication"
  default     = ""
}

variable "droplet_name" {
  description = "Droplet name in DigitalOcean"
  default     = "VPN-Proxy-droplet"
}

variable "region" {
  description = "A datacenter where droplet will be depoyed. https://developers.digitalocean.com/documentation/v2/#regions"
  default     = "nyc3"
}

variable "ssh_key_path" {
  description = "Absolute path to ssh key"
  default     = ""
}

variable "proxy_user" {
  description = "Username to authenticate in SOCKS5 proxy"
  default     = ""
}

variable "proxy_password" {
  description = "Password to authenticate in SOCKS5 proxy"
  default     = ""
}

variable "proxy_port" {
  description = "Network port for SOCKS5 proxy"
  default     = "1080"
}

variable "vpn_user" {
  description = "VPN username. DO NOT use these special characters within values: \\ \" '"
  default     = "vpnuser"
}

variable "vpn_password" {
  description = "VPN password. DO NOT use these special characters within values: \\ \" ' "
  default     = ""
}

variable "vpn_ipsec_psk" {
  description = "IPsec pre-shared key. DO NOT use these special characters within values: \\ \" ' "
  default     = ""
}

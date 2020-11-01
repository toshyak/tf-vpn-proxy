provider "digitalocean" {
  token = var.do_token
}

locals {
  user_data_vars = {
    proxy_user     = var.proxy_user
    proxy_password = var.proxy_password
    proxy_port     = var.proxy_port
    vpn_user       = var.vpn_user
    vpn_password   = var.vpn_password
    vpn_ipsec_psk  = var.vpn_ipsec_psk
  }
}


resource "digitalocean_ssh_key" "ssh_key" {
  name       = "TF ssh key"
  public_key = file(var.ssh_key_path)
}

resource "digitalocean_droplet" "vpn_proxy" {
  name      = var.droplet_name
  image     = "docker-20-04" #Docker 17.12.0~ce on Ubuntu 16.04
  region    = var.region
  size      = "s-1vcpu-1gb"                     #"memory":1024,"vcpus":1,"disk":25,"transfer":1.0,"price_monthly":5.0
  ssh_keys  = [digitalocean_ssh_key.ssh_key.id] #id of ssh_key in DO, https://developers.digitalocean.com/documentation/v2/#list-all-keys
  user_data = templatefile("${path.module}/user-data.sh", local.user_data_vars)
}

output "droplet_ip" {
  value = digitalocean_droplet.vpn_proxy.ipv4_address
}

output "Telegram_configuration_link" {
  value = "t.me/socks?server=${digitalocean_droplet.vpn_proxy.ipv4_address}&port=${var.proxy_port}&user=${var.proxy_user}&pass=${var.proxy_password}"
}

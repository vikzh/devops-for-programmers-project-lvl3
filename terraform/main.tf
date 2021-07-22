data "digitalocean_ssh_key" "mac16" {
  name = "mac book pro 16"
}


resource "digitalocean_droplet" "servers" {
  count  = 2
  image  = "docker-20-04"
  name   = format("redmine-%02d", count.index + 1)
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.mac16.id
  ]
}

resource "digitalocean_certificate" "cert" {
  name    = "domain-cert"
  type    = "lets_encrypt"
  domains = ["redmine.victor-zhukovski.club"]
}

resource "digitalocean_loadbalancer" "public" {
  name   = "redmine-balancer"
  region = "fra1"

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 80
    target_protocol = "http"

    certificate_name = digitalocean_certificate.cert.name
  }

  healthcheck {
    port     = 80
    protocol = "http"
    path     = "/"
  }

  droplet_ids = digitalocean_droplet.servers[*].id
}
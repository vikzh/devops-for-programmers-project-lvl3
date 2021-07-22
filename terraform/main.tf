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

resource "digitalocean_certificate" "redmine-cert" {
  name    = "redmine-domain-cert"
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

    certificate_name = digitalocean_certificate.redmine-cert.name
  }

  healthcheck {
    port     = 80
    protocol = "http"
    path     = "/"
  }

  droplet_ids = digitalocean_droplet.servers[*].id
}

resource "digitalocean_record" "security-task-record" {
  domain = "victor-zhukovski.club"
  type   = "A"
  name   = "redmine"
  value  = digitalocean_loadbalancer.public.ip
}

resource "digitalocean_database_cluster" "redmine" {
  name       = "redmine"
  engine     = "pg"
  version    = 12
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
}

resource "digitalocean_database_db" "redmine" {
  cluster_id = digitalocean_database_cluster.redmine.id
  name       = "redmine"
}
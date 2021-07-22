terraform {
  backend "remote" {
    organization = "vikav"

    workspaces {
      name = "hexlet-devops"
    }
  }
}
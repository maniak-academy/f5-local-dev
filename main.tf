terraform {
  required_providers {
    bigip = {
      source  = "F5Networks/bigip"
      version = "1.13.1"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.5.0"
    }
  }
}

module "app" {
  source       = "./app"
  tenant       = "local-demo"
  vip_address  = "10.99.99.10"
  common_name  = "test.example.com"
  pki_name     = "example-dot-com"
  pool_members = ["192.168.86.48", "192.168.86.21"]
}

provider "vault" {
  address = var.vaultaddress
  token   = var.vault_token
}

provider "bigip" {
  address  = var.bigipmgmt
  username = var.bigipmgmtuser
  password = var.bigippass
}


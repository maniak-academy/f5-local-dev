terraform {
  required_providers {
    bigip = {
      source  = "F5Networks/bigip"
      version = "1.13.1"
    }
  }
}


module "app" {
  source = "./app"
}


provider "bigip" {
  address  = "192.168.86.46"
  username = "admin"
  password = "W3lcome098!"
}


provider "vault" {
  address = "http://192.168.86.69:8200"
  token   = "hvs.Wj7FJ8yYwUY8HrHGZGkrUB4x"
}

resource "vault_pki_secret_backend_cert" "app" {
  backend     = "pki_int"
  name        = "example-dot-com"
  common_name = "test.example.com"
}


resource "bigip_as3" "app_services" {
  as3_json = local.as3_json
}

resource "local_file" "as3" {
    content     = local.as3_json
    filename    = "${path.module}/as3-bigip.json"
}


locals {
    as3_json = templatefile("./as3templates/as3.tpl", {
    TENANT          = "local-demo"
    VIP_ADDRESS     = "10.99.10.10"
    mylist = [
      "10.0.0.1",
      "10.0.0.2"
    ]
    CERT        = jsonencode(vault_pki_secret_backend_cert.app.certificate)
    KEY = jsonencode(vault_pki_secret_backend_cert.app.private_key)
    CA_CHAIN = jsonencode(vault_pki_secret_backend_cert.app.ca_chain)
  })
}


# resource "bigip_as3" "app1" {
#   as3_json = data.template_file.app1.rendered
# }


# data "template_file" "app1" {
#   template = file("./as3templates/http.tpl")
#   vars = {
#     UUID        = "uuid()"
#     TENANT      = "tfc-app1-demo"
#     VIP_ADDRESS = "10.10.1.1"
#   }
# }
# resource "bigip_as3" "app1" {
#   as3_json = data.template_file.app1.rendered
# }



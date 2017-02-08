provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "openvpn" {
  image = "ubuntu-14-04-x64"
  name = "32c3-openvpn"
  region = "nyc3"
  size = "512mb"
  ssh_keys = ["${var.do_ssh_key}"]
  user_data = "${data.template_file.openvpn_userdata.rendered}"
}

data "template_file" "openvpn_userdata" {
  template = "openvpn.yml"
}

variable "do_token" {}
variable "do_ssh_key" {}

output "droplet_ip" {
  value = "${digitalocean_droplet.openvpn.ipv4_address}"
}

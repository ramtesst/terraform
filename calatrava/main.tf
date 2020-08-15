variable "nimbus_user" {

}

variable "nimbus_nsname" {

}

variable "storageclass" {
  default = "wdc-08-vc04c01-wcp-mgmt"
}

# Keep the nimbus server/config/ip values, they are fine for you to use
resource "pacific_nimbus_namespace" "ns" {
   user = "${var.nimbus_user}"
   name = "${var.nimbus_nsname}"
   nimbus_server = "NOTUSED"
   nimbus = "wdc-08-vc04"
   nimbus_config_file = "http://sc-dbc1212.eng.vmware.com/tommyl/mts-git/nimbus-configs/config/staging/wcp.json"
}

output "sv_kubeconfig" {
  value = "${pacific_nimbus_namespace.ns.kubeconfig}"
}

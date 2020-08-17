variable "nimbus_user" {

}

variable "nimbus_nsname" {

}

variable "nimbus_server" {
  default = "wdc-08-vc07"
}

variable "storageclass" {
  default = "wdc-08-vc07c01-wcp-mgmt"
}

variable "postgres_cluster_name" {

}

# Keep the nimbus server/config/ip values, they are fine for you to use
resource "pacific_nimbus_namespace" "ns" {
   user = "${var.nimbus_user}"
   name = "${var.nimbus_nsname}"
   nimbus_server = "NOTUSED"
   nimbus = "${var.nimbus_server}"
   nimbus_config_file = "http://sc-dbc1212.eng.vmware.com/tommyl/mts-git/nimbus-configs/config/staging/wcp.json"
}

resource "pacific_zalando_postgres" "tfpg5" {
   cluster_name = "${var.postgres_cluster_name}"
   namespace = "${pacific_nimbus_namespace.ns.namespace}"
   input_kubeconfig = "${pacific_nimbus_namespace.ns.kubeconfig}"
   postgres_version = "11"
   storageclass = "${var.storageclass}"
   volume_size = "100Gi"
}

output "sv_kubeconfig" {
  value = "${pacific_nimbus_namespace.ns.kubeconfig}"
}

output "sv_kubeconfig" {
  value = "${pacific_nimbus_namespace.ns.kubeconfig}"
}
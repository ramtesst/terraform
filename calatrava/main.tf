variable "nimbus_user" {

}

variable "nimbus_nsname" {

}

variable "guest_cluster_name" {

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

resource "pacific_guestcluster" "gc" {
   cluster_name = "${var.guest_cluster_name}"
   namespace = "${pacific_nimbus_namespace.ns.namespace}"
   input_kubeconfig = "${pacific_nimbus_namespace.ns.kubeconfig}"
   version = "v1.16"
   network_servicedomain = "cluster.local"
   topology_controlplane_class = "best-effort-small"
   topology_workers_class = "best-effort-small"
   topology_workers_count = 1
   topology_controlplane_storageclass = "${var.storageclass}"
   topology_workers_storageclass = "${var.storageclass}"
   storage_defaultclass = "${var.storageclass}"
   tags = {
      foo = "bar-1"
      bar = "foo-1"
   }
}

output "sv_kubeconfig" {
  value = "${pacific_nimbus_namespace.ns.kubeconfig}"
}

output "gc_kubeconfig" {
  value = "${pacific_guestcluster.gc.kubeconfig}"
}

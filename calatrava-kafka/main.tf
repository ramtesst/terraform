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

variable "kafka_cluster_name" {

}

# Keep the nimbus server/config/ip values, they are fine for you to use
resource "pacific_nimbus_namespace" "ns" {
   user = "${var.nimbus_user}"
   name = "${var.nimbus_nsname}"
   nimbus_server = "NOTUSED"
   nimbus = "${var.nimbus_server}"
   nimbus_config_file = "http://sc-dbc1212.eng.vmware.com/tommyl/mts-git/nimbus-configs/config/staging/wcp.json"
}

resource "pacific_kafka_kafka" "tfkafka6" {
   cluster_name = "${var.kafka_cluster_name}"
   number_of_broker_nodes = 1
   namespace = "${pacific_nimbus_namespace.ns.namespace}"
   input_kubeconfig = "${pacific_nimbus_namespace.ns.kubeconfig}"
   kafka_version = "2.4.0"
   broker_storageclass = "${var.storageclass}"
   broker_volume_size = "100Gi"
   zookeeper_storageclass = "${var.storageclass}"
   zookeeper_volume_size = "100Gi"
   secure = false
   
   # Encryption
   # CpU/Mem size

   tags = {
      foo = "bar-1"
      bar = "foo-1"
   }
}
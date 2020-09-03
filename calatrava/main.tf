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

variable "rabbitmq_cluster_name" {

}

variable "minio_cluster_name" {

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

resource "pacific_pivotal_rabbitmq" "tfrabbitmq1" {
   cluster_name = "${var.rabbitmq_cluster_name}"
   replicas = 3
   namespace = "${pacific_nimbus_namespace.ns.namespace}"
   input_kubeconfig = "${pacific_nimbus_namespace.ns.kubeconfig}"
   storageclass = "${var.storageclass}"
   service_type = "LoadBalancer"
   volume_size = "100Gi"
   image = "sabu-persistence-service-docker-local.artifactory.eng.vmware.com/rabbitmq:mar30-1"
   resources {
      requests {
         cpu = "1000m"
         memory = "2Gi"
      }
      limits {
         cpu = "2000m"
         memory = "2Gi"
      }
   }
   
   tags = {
      foo = "bar-1"
      bar = "foo-1"
   }
}

resource "pacific_minio" "tfminio1" {
   cluster_name = "${var.minio_cluster_name}"
   namespace = "${pacific_nimbus_namespace.ns.namespace}"
   input_kubeconfig = "${pacific_nimbus_namespace.ns.kubeconfig}"
   storageclass = "${var.storageclass}"
   volume_size = "100Gi"
   access_key = "minio"
   secret_key = "minio123"
   replicas = 4

   # Encryption
   # CpU/Mem size

   tags = {
      foo = "bar-1"
      bar = "foo-1"
   }
}

output "sv_kubeconfig" {
  value = "${pacific_nimbus_namespace.ns.kubeconfig}"
}
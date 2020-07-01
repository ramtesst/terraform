provider "google" {
#  credentials = file("account.json")
  project     = "abx-service-for-tango"
  region      = "asia-east1"
  zone        = "asia-east1-a"
}

variable "prefix" {
  default = "vmware-gadagip-test"
}

resource "google_compute_instance" "vm_instance" {
  name         = "${var.prefix}-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }
}

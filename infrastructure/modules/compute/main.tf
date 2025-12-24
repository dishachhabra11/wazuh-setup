resource "google_compute_instance" "this" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network    = var.network  # use module.network.vpc_name
    subnetwork = var.subnet   # use module.network.subnet_names
    access_config {}  # gives external IP
  }
}

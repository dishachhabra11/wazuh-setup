resource "random_id" "template_suffix" {
  byte_length = 4
}

resource "google_compute_instance_template" "app-template" {
  name         = "${var.name_prefix}-template-${random_id.template_suffix.hex}"
  machine_type = var.machine_type

  disk {
    source_image = var.source_image
    disk_size_gb = var.disk_size_gb
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnet
    access_config {}    # gives external IP
  }

  metadata = var.metadata         # for startup script, etc.
  tags     = var.network_tags

  lifecycle {
  create_before_destroy = true
}

}

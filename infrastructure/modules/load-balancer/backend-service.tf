resource "google_compute_backend_service" "tcp_backend" {
  name                  = "${var.env}-tcp-backend"
  protocol              = "TCP"
  load_balancing_scheme = "EXTERNAL"
  health_checks         = [google_compute_health_check.tcp_health.id]

  backend {
    group = var.mig_instance_group  # pass the MIG self_link here
  }
  lifecycle {
    create_before_destroy = true
  }
}

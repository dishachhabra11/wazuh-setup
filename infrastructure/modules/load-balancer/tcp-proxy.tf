resource "google_compute_target_tcp_proxy" "tcp_proxy" {
  name           = "${var.env}-tcp-proxy"
  backend_service = google_compute_backend_service.tcp_backend.id
}

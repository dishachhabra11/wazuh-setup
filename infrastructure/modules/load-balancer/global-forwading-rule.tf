resource "google_compute_global_forwarding_rule" "tcp_lb" {
  name                  = "${var.env}-tcp-lb"
  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"
  port_range            = var.port_range
  target                = google_compute_target_tcp_proxy.tcp_proxy.id
  ip_address            = google_compute_global_address.lb_ip.address
}

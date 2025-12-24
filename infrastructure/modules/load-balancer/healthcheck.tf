resource "google_compute_health_check" "tcp_health" {
  name = "${var.env}-tcp-hc"

  tcp_health_check {
    port = var.lb_port
  }

  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
}

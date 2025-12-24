resource "google_compute_subnetwork" "subnets" {

for_each = {for s in var.subnets : s.name => s}

  name          = each.value.name
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = each.value.cidr_range
  
}

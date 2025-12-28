resource "google_compute_firewall" "general" {
  name    = "${var.vpc_name}-wazuh-general"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }


  source_ranges = ["0.0.0.0/0"]
}


resource "google_compute_firewall" "wazuh_internal" {
  name    = "${var.vpc_name}-wazuh-internal"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["1514", "1515", "1516", "55000", "514"]
  }

  allow {
    protocol = "udp"
    ports    = ["1514", "514"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["wazuh-server"]
}


resource "google_compute_firewall" "wazuh_manager" {
  name    = "${var.vpc_name}-wazuh-manager"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["1514", "1515", "1516"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["wazuh-manager"]
}

resource "google_compute_firewall" "wazuh_indexer" {
  name    = "${var.vpc_name}-wazuh-indexer"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["9200", "9300" , "9400"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["wazuh-indexer"]
}

resource "google_compute_firewall" "wazuh_dashboard" {
  name    = "${var.vpc_name}-wazuh-dashboard"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["443", "5601"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["wazuh-dashboard"]
}

resource "google_compute_firewall" "application" {
  name    = "${var.vpc_name}-wazuh-dashboard"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["1514" , "1515"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["application"]

  lifecycle{
    create_before_destroy = true 
  }
}


output "mig_name" {
  value = google_compute_region_instance_group_manager.app_mig.name
}

output "instance_group_self_link" {
  value = google_compute_region_instance_group_manager.app_mig.self_link
}


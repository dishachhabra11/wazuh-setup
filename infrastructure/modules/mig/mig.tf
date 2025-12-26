resource "google_compute_region_instance_group_manager" "app_mig" {
  project             = var.project_id
  name                = "${var.name_prefix}-mig"
  region              = var.region
  base_instance_name  = var.name_prefix
  version {
    instance_template = var.instance_template_id
  }
  target_size = var.target_size


  # Optional autoscaling block can be added later
}

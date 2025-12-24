module "network" {
  source     = "./modules/network"
  project_id = var.project_id
  region     = var.region
  vpc_name   = "${var.env}-wazuh-vpc"

  subnets = [
  { name = "${var.env}-subnet-1", cidr_range = "10.10.1.0/24" },
  { name = "${var.env}-subnet-2", cidr_range = "10.10.2.0/24" }
]

}


module "master1" {
  source       = "./modules/compute"
  name         = "wazuh-master"
  machine_type = "e2-small"
  zone         = var.zone
  image        = "ubuntu-minimal-2204-lts"
  network      = module.network.vpc_name
  subnet       = element(module.network.subnet_names, 0)  # gets the first subnet_names
}

module "worker1" {
  source       = "./modules/compute"
  name         = "wazuh-worker1"
  machine_type = "e2-small"
  zone         = var.zone
  image        = "ubuntu-minimal-2204-lts"
  network      = module.network.vpc_name
  subnet       = element(module.network.subnet_names, 0)  # gets the first subnet_names
}

module "worker2" {
  source       = "./modules/compute"
  name         = "wazuh-worker2"
  machine_type = "e2-small"
  zone         = var.zone
  image        = "ubuntu-minimal-2204-lts"
  network      = module.network.vpc_name
  subnet       = element(module.network.subnet_names, 0)  # gets the first subnet_names
}

module "indexer1" {
  source       = "./modules/compute"
  name         = "wazuh-indexer-1"
  machine_type = "e2-small"
  zone         = var.zone
  image        = "ubuntu-minimal-2204-lts"
  network      = module.network.vpc_name
  subnet       = element(module.network.subnet_names, 0)  # gets the first subnet_names
}

module "indexer2" {
  source       = "./modules/compute"
  name         = "wazuh-indexer-2"
  machine_type = "e2-small"
  zone         = var.zone
  image        = "ubuntu-minimal-2204-lts"
  network      = module.network.vpc_name
  subnet       = element(module.network.subnet_names, 0)  # gets the first subnet_names
}

module "dashboard" {
  source       = "./modules/compute"
  name         = "dashboard"
  machine_type = "e2-small"
  zone         = var.zone
  image        = "ubuntu-minimal-2204-lts"
  network      = module.network.vpc_name
  subnet       = element(module.network.subnet_names, 1)  # gets the second subnet_names
}

module "app_template" {
  source               = "./modules/mig"
  name_prefix          = "${var.env}-app"
  project_id           = var.project_id
  region               = var.region
  machine_type         = "e2-standard-2"
  source_image         = "projects/debian-cloud/global/images/family/debian-11"
  network              = module.network.vpc_name
  subnet               = element(module.network.subnet_names, 0)
  service_account_email = var.default_service_account
  network_tags         = ["app"]
  metadata             = {
    metadata_startup_script = file("${path.module}/../scripts/app-startup.sh")
  }
}

module "app_mig" {
  source               = "./modules/mig"
  project_id           = var.project_id
  region               = var.region
  name_prefix          = "${var.env}-app"
  instance_template_id = module.mig.instance_template_id
  target_size          = 2
}

module "wazuh_lb" {
  source              = "./modules/load-balancer"
  env                 = var.env
  lb_port             = "1514"
  mig_instance_group  = module.mig.instance_group_self_link
}









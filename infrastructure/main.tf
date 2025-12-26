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
  tags         =["wazuh-manager"]
}

module "application-1" {
  source       = "./modules/compute"
  name         = "application-1"
  machine_type = "e2-small"
  zone         = var.zone
  image        = "ubuntu-minimal-2204-lts"
  network      = module.network.vpc_name
  subnet       = element(module.network.subnet_names, 0)  # gets the first subnet_names
  tags         = ["application"]

}

module "application-2" {
  source       = "./modules/compute"
  name         = "application-2"
  machine_type = "e2-small"
  zone         = var.zone
  image        = "ubuntu-minimal-2204-lts"
  network      = module.network.vpc_name
  subnet       = element(module.network.subnet_names, 0)  # gets the first subnet_names
  tags         = ["application"]
}

module "indexer1" {
  source       = "./modules/compute"
  name         = "wazuh-indexer-1"
  machine_type = "e2-small"
  zone         = var.zone
  image        = "ubuntu-minimal-2204-lts"
  network      = module.network.vpc_name
  subnet       = element(module.network.subnet_names, 0)  # gets the first subnet_names
  tags         =["wazuh-indexer"]
}

module "dashboard" {
  source       = "./modules/compute"
  name         = "dashboard"
  machine_type = "e2-small"
  zone         = var.zone
  image        = "ubuntu-minimal-2204-lts"
  network      = module.network.vpc_name
  subnet       = element(module.network.subnet_names, 1)  # gets the second subnet_names
   tags         =["wazuh-dashboard"]

}

module "app_template" {
  source               = "./modules/instance-template"
  name_prefix         = "${var.env}-worker"
  machine_type         = "e2-standard-2"
  source_image         = "projects/debian-cloud/global/images/family/debian-11"
  network              = module.network.vpc_name
  subnet               = element(module.network.subnet_names, 0)
  network_tags         = ["wazuh-server"]

  metadata             = {
    metadata_startup_script = file("${path.module}/scripts/app-startup.sh")
  }
}

module "app_mig" {
  source               = "./modules/mig"
  project_id           = var.project_id
  region               = var.region
  name_prefix          = "wazuh-manager"
  instance_template_id = module.app_template.instance_template_id
  target_size          = 2
}

module "wazuh_lb" {
  source              = "./modules/load-balancer"
  env                 = var.env
  lb_port             = "1514"
  mig_instance_group  = module.app_mig.instance_group_self_link
}









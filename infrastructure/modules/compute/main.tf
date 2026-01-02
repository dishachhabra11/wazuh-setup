resource "google_compute_instance" "this" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  tags= var.tags

  network_interface {
    network    = var.network  # use module.network.vpc_name
    subnetwork = var.subnet   # use module.network.subnet_names
    access_config {}  # gives external IP
  }

    metadata_startup_script = <<-EOF
    #!/bin/bash
    
    # update packages
    apt update -y
    
    # install nginx as a simple app
    apt install -y nginx
    
    # write a simple index page
    echo "<html><body><h1>Hello from GCP VM!</h1></body></html>" > /var/www/html/index.nginx-debian.html
    
    # start nginx
    systemctl enable nginx
    systemctl start nginx
  EOF
  
}

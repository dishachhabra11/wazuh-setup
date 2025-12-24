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

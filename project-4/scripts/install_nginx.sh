#!/bin/bash
# Update package list
apt-get update

# Install Nginx
apt-get install -y nginx

echo "Hello World from $(hostname)" > /var/www/html/index.html 

# restart Nginx service
systemctl restart nginx

# Enable Nginx to start on boot
systemctl enable nginx

# Disable the firewall
ufw disable 



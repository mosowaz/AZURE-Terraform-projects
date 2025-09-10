#!/bin/bash
# Update package list
apt-get update && apt-get dist-upgrade -y

# Install Nginx
apt-get install -y nginx

chmod -R 777 /var/www/html
mkdir -p /var/www/html/videos
echo "Welcome to the VIDEOS subpage hosted by $(hostname)" > /var/www/html/videos/index.html

# restart Nginx service
systemctl restart nginx

# Enable Nginx to start on boot
systemctl enable nginx

# Disable the firewall
ufw disable 
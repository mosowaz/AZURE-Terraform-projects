#!/bin/bash
# Update package list
apt-get update && apt-get dist-upgrade -y

# Install Nginx
apt-get install -y nginx

# Create directory for images web pages
mkdir /var/www/images

# Display content from default and images page
echo "Welcome to the DEFAULT page hosted by $(hostname)" > /var/www/html/index.html
echo "Welcome to the IMAGES page hosted by $(hostname)" > /var/www/images/index.html

# restart Nginx service
systemctl restart nginx

# Enable Nginx to start on boot
systemctl enable nginx

# Disable the firewall
ufw disable 



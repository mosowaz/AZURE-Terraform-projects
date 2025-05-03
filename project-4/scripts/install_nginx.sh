#!/bin/bash

# Update package list
apt-get update

# Install Nginx
apt-get install -y nginx

# Start Nginx service
systemctl start nginx

# Enable Nginx to start on boot
systemctl enable nginx

# Disable the firewall
ufw disable




#!/bin/bash

# Update package list
sudo apt update

# Install Nginx
sudo apt install -y nginx

# Allow Nginx HTTP (port 80) through the firewall
sudo ufw allow 'Nginx HTTP'

# Allow Nginx HTTPS (port 443) through the firewall
sudo ufw allow 'Nginx HTTPS'

# Enable the firewall
sudo ufw enable

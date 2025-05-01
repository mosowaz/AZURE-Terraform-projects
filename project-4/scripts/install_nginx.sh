#!/bin/bash

# Update package list
sudo apt update

# Install Nginx
sudo apt install -y nginx

# Disable the firewall
sudo ufw disable

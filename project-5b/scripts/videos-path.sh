#!/bin/bash
# Update package list
apt-get update && apt-get dist-upgrade -y

# Install Nginx
apt-get install -y nginx

# Create directories for default and images web pages
mkdir /var/www/videos

# Display content from default and images page
echo "Welcome to the VIDEOS page hosted by $(hostname)" > /var/www/videos/index.html

# update nginx config file
tee /etc/nginx/sites-available/default > /dev/null <<EOF
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm;

    server_name _;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location /videos/ {
        root /var/www;
        index index.html;
    }
}
EOF

# restart Nginx service
systemctl restart nginx

# Enable Nginx to start on boot
systemctl enable nginx

# Disable the firewall
ufw disable 



#!/bin/bash
apt-get update
apt-get install -y nginx
echo "Hello, OpenTofu!" > /var/www/html/index.html
systemctl start nginx
systemctl enable nginx
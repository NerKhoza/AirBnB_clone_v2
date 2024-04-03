#!/usr/bin/env bash
# script that sets up your web servers for the deployment

if ! command -v nginx &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y nginx
fi

sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/

echo "<html><body>Test Page</body></html>" | sudo tee /data/web_static/releases/test/index.html > /dev/null

sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

sudo chown -R ubuntu:ubuntu /data/

sudo sed -i 's/^\(\s*location \/hbnb_static\).*$/\1 {\n\talias \/data\/web_static\/current\/;\n\t}/' /etc/nginx/sites-available/default

sudo systemctl restart nginx

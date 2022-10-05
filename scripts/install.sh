#! /bin/bash

sudo apt-get update
sudo apt-get install -y nginx
sudo chown -R ubuntu:ubuntu /etc/nginx/
> /etc/nginx/nginx.conf
echo -e "
events {
  worker_connections  4096;  ## Default: 1024
}

http {
  server {
    listen 80;
    server_name /;
    location / {
        proxy_pass https://github.com/fabiosdsilva/infraestutura-terraform;
    }
  }
}
" > /etc/nginx/nginx.conf
sudo service nginx restart
#!/bin/env bash
# 
# Generate nginx virtual host
# 
# Usage: ./2-generate-vhost.sh example.com

vhost=$1

if [ "$vhost" != "" ]; 
then

cat <<EOT > "/etc/nginx/conf.d/${vhost}.conf"
server {
    listen 80;
    server_name ${vhost};

    location / {
        root /var/www/html;
        index index.html;
    }
}
EOT

echo "<h1>You are in ${vhost}</h1>" > /var/www/html/index.html

nginx -t
nginx -s reload

else

echo "You should give an argument(virtual host)"
exit 1

fi
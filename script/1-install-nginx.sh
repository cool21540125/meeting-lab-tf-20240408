#!/bin/env bash
# 
# Usage: ./1-install-nginx.sh

#

### running?
if [ -e /var/run/nginx.pid ]; then
  echo "========================"
  echo "nginx is installed and running"
  echo "========================"
  exit 0
fi

### installed?
if [ -x "$(command -v nginx)" ]; then
  echo "========================"
  echo "nginx is installed, but not running"
  echo "========================"
  exit 0
fi


### Linux distribution
if [ "$(cat /etc/*-release | grep centos | wc -l)" != "0" ];
then

curl http://nginx.org/keys/nginx_signing.key > nginx_signing.key
rpm --import nginx_signing.key

cat <<"EOT" > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=https://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
EOT
yum-config-manager --enable nginx
yum install -y nginx

elif [ "$(cat /etc/*-release | grep ubuntu | wc -l)" != "0" ];
then

apt-get update
apt-get install -y nginx

else

echo "========================"
echo "the installation of nginx on other distrubution is not implemented"
echo "========================"
exit 0

fi

echo "========================"
echo "nginx installed Succeed!"
echo "========================"
exit 0
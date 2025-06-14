#!/bin/bash
apt update
apt upgrade -y
apt install unzip wget apache2 -y
systemctl start apache2
systemctl enable apache2
wget  https://www.tooplate.com/zip-templates/2117_infinite_loop.zip
unzip 2117_infinite_loop.zip
cp -r /var/tmp/2117_infinite_loop/* /var/www/html/
systemctl restart apache2


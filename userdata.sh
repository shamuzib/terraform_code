#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service
echo "Hello Hallam from $(hostname -f)" > /var/www/html/index.html

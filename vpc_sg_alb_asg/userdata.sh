#!/bin/bash
# Switch to the root user
sudo su

# Update all packages
yum update -y

# Install Apache HTTP Server
yum install -y httpd

# Change directory to Apache web root
cd /var/www/html

# Install Git
yum install git -y

# Clone the project repository
git clone https://github.com/aosnotes77/host-a-static-website-on-aws.git

# Copy repository contents to web root
cp -R host-a-static-website-on-aws/. /var/www/html/

# Remove the cloned repository directory
rm -rf host-a-static-website-on-aws

# Enable Apache HTTP Server on boot
systemctl enable httpd

# Start Apache HTTP Server
systemctl start httpd
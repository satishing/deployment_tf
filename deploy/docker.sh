#!/bin/bash

set -x

sudo yum update -y

sleep 10

# Setting up Docker
sudo yum install -y docker
sudo usermod -a -G docker ec2-user

# Just to be safe removing previously available java if present
sudo yum remove -y java
sleep 20
sudo yum install -y python2-pip jq unzip vim tree biosdevname bind-utils at screen tmux  git java-1.8.0-openjdk nc 
sudo -H pip install bcrypt
sudo -H pip install docker

sudo systemctl enable docker
sudo systemctl enable atd
sudo systemctl enable --now docker

sudo yum clean all
sudo rm -rf /var/cache/yum/
exit 0
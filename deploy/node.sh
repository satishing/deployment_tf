#!/usr/bin/env bash

sudo apt update -y
cd ~
curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs -y
nodejs -v
npm -v
sudo apt install build-essential -y 

sudo npm install pm2@latest -g -y 
pm2 startup systemd
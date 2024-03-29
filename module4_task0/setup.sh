#!/bin/bash
apt update && apt upgrade -y
apt install -y wget make dpkg curl sudo
wget -O hugo_binary.deb https://github.com/gohugoio/hugo/releases/download/v0.111.3/hugo_extended_0.111.3_linux-amd64.deb
sudo dpkg -i hugo_binary.deb
rm hugo_binary.deb
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin 
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
sudo apt-get install -y nodejs
sudo npm install -g markdown-link-check
sudo npm install -g markdownlint-cli
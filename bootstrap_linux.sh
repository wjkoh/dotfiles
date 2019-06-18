#!/bin/bash
./pre_bootstrap.sh

# Update the package index files first.
sudo apt update

curl -sfL git.io/antibody | sh -s - -b /usr/local/bin || exit
sudo apt install fd-find
sudo apt install htop
sudo apt install nodejs
sudo apt install python-pip
sudo apt install python3-pip
sudo apt install silversearcher-ag
sudo apt install stow
sudo apt install urlview

./post_bootstrap.sh

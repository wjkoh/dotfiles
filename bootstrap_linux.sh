#!/bin/bash
./pre_bootstrap.sh

# Update the package index files first.
sudo apt update

curl -sL git.io/antibody | sh -s
sudo apt install fd-find
sudo apt install python-pip
sudo apt install silversearcher-ag
sudo apt install stow

./post_bootstrap.sh

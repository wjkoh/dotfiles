#!/bin/bash
./pre_bootstrap.sh

curl -sL git.io/antibody | sh -s
sudo apt install fd-find
sudo apt install python-pip
sudo apt install stow

./post_bootstrap.sh

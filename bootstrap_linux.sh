#!/bin/bash
./pre_bootstrap.sh

curl -sL git.io/antibody | sh -s
sudo apt install stow

./post_bootstrap.sh

#!/bin/bash

./bootstrap_common.sh

curl -sL git.io/antibody | sh -s

sudo apt install stow

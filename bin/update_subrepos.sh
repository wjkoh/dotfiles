#!/usr/bin/env bash

# Git
hg onsub --ignore-errors "git checkout master"
hg onsub --ignore-errors "git pull"
cd .vim/bundle/vim-powerline/; git checkout develop

# Mercurial
hg onsub --ignore-errors "hg pull --update"

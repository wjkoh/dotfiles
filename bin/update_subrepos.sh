#!/usr/bin/env bash

# Git
hg onsub --ignore-errors "git checkout master"
hg onsub --ignore-errors "git pull"
hg onsub --ignore-errors "git submodule update --init --recursive"

# Mercurial
hg onsub --ignore-errors "hg pull --update"

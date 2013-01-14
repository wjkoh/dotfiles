#!/usr/bin/env bash

find . -name "*.cloth" -or -name "*.root" | xargs tar rvf cloth_and_root_files.tar

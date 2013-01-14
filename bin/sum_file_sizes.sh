#!/usr/bin/env bash

# http://stackoverflow.com/questions/599027/calculate-size-of-files-in-shell
find -L karate_snu/ -name "*.cloth" -ls | awk '{total += $7} END {print NR, total}'

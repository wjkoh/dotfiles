#!/usr/bin/env bash

# http://stackoverflow.com/a/17110941
tar -c --use-compress-program=pigz -f $1 $2

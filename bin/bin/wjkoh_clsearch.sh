#!/bin/sh

LAST_SATURDAY=$(date +"%Y-%m-%d" -d "last saturday")

# Do not use from:... for pending CLs because some can be from very old.
# Submitted CLs are okay ecuase from: detects created or submitted dates.
# TODO(wjkoh): ; s/\'\(.*$\)\'/\1/
clsearch -desc_length=100 author:$USER is:submitted from:$LAST_SATURDAY | cut -d\  -f 1,6- | sed 's/^http:\/\///; s/^/* Submitted: /; s/  .*$//'
clsearch -desc_length=100 author:$USER is:pending reviewer:.+ | cut -d\  -f 1,7- | sed 's/^http:\/\///; s/^/* Under review: /; s/  .*$//'

#!/usr/bin/env sh

SUBJECT=$(hg log -r $HG_NODE --template '{desc|firstline}')

(
    echo Hg: $SUBJECT
) | dayone new

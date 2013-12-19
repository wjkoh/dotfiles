#!/bin/sh

# http://stackoverflow.com/a/3452888
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs sudo pip install -U

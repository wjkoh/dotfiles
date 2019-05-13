#!/bin/sh

LAST_SATURDAY=$(date +"%Y-%m-%d" -d "last saturday")
REMOVE_HTTP='s/^http:\/\///; '
PREPEND_SUBMITTED='s/^/* Submitted: /; '
PREPEND_UNDER_REVIEW='s/^/* Under review: /; '
REPLACE_SINGLE_QUOTES='s/\x27\(.*\)\x27/`\1`/g; '
KEEP_ONLY_FIRST_LINE='s/  .*`/`/'

clsearch -desc_length=100 author:$USER is:submitted from:$LAST_SATURDAY | cut -d\  -f 1,6- \
  | sed "$REMOVE_HTTP $PREPEND_SUBMITTED $REPLACE_SINGLE_QUOTES $KEEP_ONLY_FIRST_LINE"

# Do not use from:... for pending CLs because some can be from very old.
# Submitted CLs are okay ecuase from: detects created or submitted dates.
clsearch -desc_length=100 author:$USER is:pending reviewer:.+ | cut -d\  -f 1,7- \
  | sed "$REMOVE_HTTP $PREPEND_UNDER_REVIEW $REPLACE_SINGLE_QUOTES $KEEP_ONLY_FIRST_LINE"

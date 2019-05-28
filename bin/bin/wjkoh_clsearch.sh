#!/bin/sh

function list_cls_from_to() {
  REMOVE_HTTP='s/^http:\/\///; '
  PREPEND_SUBMITTED='s/^/* Submitted: /; '
  PREPEND_UNDER_REVIEW='s/^/* Under review: /; '
  REPLACE_SINGLE_QUOTES='s/\x27\(.*\)\x27/`\1`/g; '
  KEEP_ONLY_FIRST_LINE='s/  .*`/`/'

  clsearch -desc_length=100 author:$USER is:submitted from:$1 to:$2 | cut -d\  -f 1,6- \
    | sed "$REMOVE_HTTP $PREPEND_SUBMITTED $REPLACE_SINGLE_QUOTES $KEEP_ONLY_FIRST_LINE"

  # Do not use from:... for pending CLs because some can be from very old.
  # Submitted CLs are okay ecuase from: detects created or submitted dates.
  clsearch -desc_length=100 author:$USER is:pending reviewer:.+ | cut -d\  -f 1,7- \
    | sed "$REMOVE_HTTP $PREPEND_UNDER_REVIEW $REPLACE_SINGLE_QUOTES $KEEP_ONLY_FIRST_LINE"
} 

NOW=$(date +"%Y-%m-%d" -d "now")
LAST_SATURDAY=$(date +"%Y-%m-%d" -d "last saturday")
SATURDAY_BEFORE_LAST_SATURDAY=$(date +"%Y-%m-%d" -d "last saturday - 7 days")

echo 'This week:'
list_cls_from_to $LAST_SATURDAY $NOW

echo
echo 'Last week (just in case you forgot to add them to your snippet):'
list_cls_from_to $SATURDAY_BEFORE_LAST_SATURDAY $LAST_SATURDAY

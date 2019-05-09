#!/bin/sh

# TODO(wjkoh): Enable syntax highlighting for code preview.
csearch --color=always --context=5 -nostats --alphasort=false -n \
  "$@" \
  | sed 's/^File \(.*$\)/\x0\1:/g; s/^=\+$//g' \
  | fzf --read0 --delimiter=: --nth=1 --preview='echo -ne {2..}' --ansi --with-nth=1 --no-sort

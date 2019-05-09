#!/bin/sh

# TODO(wjkoh): Return only a filename when exit.
# TODO(wjkoh): Enable syntax highlighting for code preview. For example, extract
# a file extension and give it to bat or other highlighters.
csearch --color=always --context=5 -nostats --alphasort=false -n \
  "$@" \
  | sed 's/^File \(.*$\)/\x0\1:/g; s/^=\+$//g' \
  | fzf --read0 --delimiter=: --nth=1 --preview='echo -ne {2..}' --ansi --with-nth=1 --no-sort

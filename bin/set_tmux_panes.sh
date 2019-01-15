#!/bin/sh
#
# Setup a work space called `work` with two windows
# first window has 3 panes. 
# The first pane set at 65%, split horizontally, set to api root and running vim
# pane 2 is split at 25% and running redis-server 
# pane 3 is set to api root and bash prompt.
# note: `api` aliased to `cd ~/path/to/work`
#
session="work"

PROJECT_ROOT=$(p4 g4d $*)
if [ $? -ne 0 ]
then
  exit 1
fi
# cd ${PROJECT_ROOT} || exit

tmx2 new-session -d -s $session -n "$*" -c "${PROJECT_ROOT}" || tmux new-window -t $session -c "${PROJECT_ROOT}" -n "$*"|| exit

tmux split-window -h -c "${PROJECT_ROOT}"
tmx2 splitw -v -p 50 -c "${PROJECT_ROOT}"
tmux select-pane -t 1
tmx2 splitw -v -p 50 -c "${PROJECT_ROOT}"

tmux select-pane -t 1
tmx2 send-keys "hg watch" C-m

tmx2 selectp -t 2
tmx2 send-keys "set_project_dirs && ~/bin/wjkoh_iblaze_test_all.sh \${PROJECT_DIRS[@]}" C-m
tmx2 selectp -t 0

tmx2 attach-session -t $session

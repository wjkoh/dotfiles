#!/bin/bash

# -iblaze_run_before 'tmux select-pane -t $TMUX_PANE -P "bg=yellow"'
# -iblaze_run_after 'tmux select-pane -t $TMUX_PANE -P "bg=green"'
# -iblaze_run_after_failure 'tmux select-pane -t $TMUX_PANE -P "bg=red"'

iblaze -iblaze_interrupt_on_change \
  -iblaze_nocitc_watch_all \
  -iblaze_run_before \
  'echo -ne "\e]50;ClearScrollback\a"; tmux clear-history -t $TMUX_PANE' \
  "$@"

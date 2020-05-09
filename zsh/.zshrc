EDITOR=vim
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
MANPAGER='vim -M +MANPAGER -'
PAGER=less
SAVEHIST=100000
VISUAL=vim

# If you want programs run from zsh to see the var, export it.
export PATH=$HOME/bin:$PATH:$HOME/.local/bin

autoload -Uz compinit
compinit
zmodload -i zsh/complist

setopt ALWAYS_TO_END        # move cursor to end if word had one match
setopt AUTO_CD              # cd by typing directory name if it's not a command
setopt AUTO_LIST            # automatically list choices on ambiguous completion
setopt AUTO_MENU            # automatically use menu completion
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt CORRECT_ALL          # autocorrect commands
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_ALL_DUPS # remove older duplicate entries from history
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_REDUCE_BLANKS   # remove superfluous blanks from history items
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt INC_APPEND_HISTORY   # save history entries as soon as they are entered
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt SHARE_HISTORY        # share history between different instances of the shell

source <(antibody init)

antibody bundle denysdovhan/spaceship-prompt
antibody bundle marzocchi/zsh-notify
antibody bundle zdharma/fast-syntax-highlighting
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-completions

# Mercurial section causes slowness.
SPACESHIP_HG_SHOW=false

# FZF.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

FD='fdfind --hidden --color=never'
FIND_ALL_DIRS="($FD --type d . waymo third_party/car) 2> /dev/null ; $FD --type d --exclude waymo --exclude third_party/car"
FIND_ALL_FILES="($FD --type f . waymo third_party/car) 2> /dev/null ; $FD --type f --exclude waymo --exclude third_party/car"
FIND_VCS_FILES='(hg files . || git ls-files .) 2> /dev/null'

# Remove some consecutive duplicates here with `uniq`. All duplicates will be
# completely removed at the last stage by `nauniq`.
FIND_VCS_DIRS="$FIND_VCS_FILES | xargs -n 1 dirname | uniq"

# `awk '!mem[$0]++'` is equivalent to `nauniq`.
export FZF_ALT_C_COMMAND="($FIND_VCS_DIRS; $FIND_ALL_DIRS) | awk '!mem[\$0]++'"
export FZF_DEFAULT_COMMAND="($FIND_VCS_FILES ; $FIND_ALL_FILES) | awk '!mem[\$0]++'"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# Open .zshrc to be edited in VS Code
alias change="$EDITOR ~/.zshrc"
# Re-run source command on .zshrc to update current terminal session with new settings
alias update='source ~/.zshrc'
# Vim: Load all modified files in this mercurial repository into buffers.
alias vimhg='vim $(hg changeddot)'
# Or, use `qmv` and use a column-conditioned substitute, e.g., :%s/\%>11cOLD_TEXT/NEW_TEXT/g.
alias vimrename='vidir'
# Load modified and untracked files. See https://stackoverflow.com/a/2299448.
alias vimgit='vim $(git ls-files --modified --others --exclude-standard .)'

alias capture_pane='tmux capture-pane -b wjkoh-capture -S - \; show-buffer -b wjkoh-capture \; delete-buffer -b wjkoh-capture'
alias split_by_spaces='awk -F" " '\''{for (i = 1; i <= NF; i++) print $i}'\'
alias vimpane='capture_pane | vipe'
# TODO(wjkoh): output a string containing '.' as well?
alias vimpaths='capture_pane | split_by_spaces | grep / | sort | uniq | vipe'
alias fzfpaths='capture_pane | split_by_spaces | grep / | sort | uniq | fzf'

source "${ZDOTDIR:-${HOME}}/.zshrc_`uname`"
if [[ -f ~/.zshrc_google ]]; then
  source ~/.zshrc_google
else
  # We cannot move the following `gcertstatus` to .zshrc_google because a corp
  # laptop, which has no access to source code, still needs `gcert` to SSH.
  (( $+commands[gcertstatus] )) && \
    (gcertstatus -ssh_cert_comment="corp/normal" -check_remaining=$((8 * 60 * 60))s || gcert)
fi

EDITOR=vim
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
PAGER=less
SAVEHIST=100000
VISUAL=vim
export PATH=$HOME/bin:$PATH

autoload -Uz compinit
compinit
zmodload -i zsh/complist

setopt always_to_end        # move cursor to end if word had one match
setopt auto_cd              # cd by typing directory name if it's not a command
setopt auto_list            # automatically list choices on ambiguous completion
setopt auto_menu            # automatically use menu completion
setopt correct_all          # autocorrect commands
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks   # remove superfluous blanks from history items
setopt inc_append_history   # save history entries as soon as they are entered
setopt share_history        # share history between different instances of the shell

source <(antibody init)

antibody bundle denysdovhan/spaceship-prompt
antibody bundle marzocchi/zsh-notify
antibody bundle zdharma/fast-syntax-highlighting
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-completions

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
FIND_MY_FILES='fd --type f . waymo/experimental/users/wjkoh 2> /dev/null'
FIND_MY_DIRECTORIES='fd --type d . waymo/experimental/users/wjkoh 2> /dev/null'
HG_AND_GIT_FILES='hg files . 2> /dev/null; git ls-files . 2> /dev/null'
# sort is required before uniq even though hg files and git ls-files output
# sorted lists because they can be out of order once filenames are removed. For
# example, [ "a/f.txt", "a/g/h.txt", "a/h.txt" ] -> [ "a", "a/b", "a" ].
HG_AND_GIT_DIRECTORIES="($HG_AND_GIT_FILES) | xargs -n 1 dirname | sort | uniq"
export FZF_DEFAULT_COMMAND="$FIND_MY_FILES; $HG_AND_GIT_FILES; fd --type f"
# Apply the default command to Ctrl-t as well.
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND="$FIND_MY_DIRECTORIES; $HG_AND_GIT_DIRECTORIES; fd --type d"

alias ssh='TERM=xterm-256color ssh'
# Open .zshrc to be edited in VS Code
alias change="$EDITOR ~/.zshrc"
# Re-run source command on .zshrc to update current terminal session with new settings
alias update='source ~/.zshrc'

# Vim: Load all modififed files in this mercurial repository into buffers.
alias vimhg='vim $(hg status --no-status --change .; hg status --no-status --added --modified --unknown)'
# Load modified and untracked files. See https://stackoverflow.com/a/2299448.
alias vimgit='vim $(git ls-files --modified --others --exclude-standard .)'

MAIN_PANE_WIDTH=$(tmux show-options -gwvq main-pane-width)
NEW_WINDOW='new-window \;'
SPLIT="split-window -h -l $MAIN_PANE_WIDTH \\;"
SELECT='select-pane -t 0 \;'
alias tmux_two_verticals="tmux $NEW_WINDOW $SPLIT $SELECT $SPLIT"
alias tmux_three_verticals="tmux $NEW_WINDOW $SPLIT $SELECT $SPLIT $SELECT $SPLIT"

source "${ZDOTDIR:-${HOME}}/.zshrc_`uname`"
[ -f ~/.zshrc_google ] && source ~/.zshrc_google

# Mercurial section causes slowness.
SPACESHIP_HG_SHOW=false

# Gcert. We cannot move the following `gcertstatus` to .zshrc_google because a
# corp laptop, which has no access to source code, still needs `gcert` to SSH.
(( $+commands[gcertstatus] )) && (gcertstatus -ssh_cert_comment="corp/normal" -check_remaining=$((8 * 60 * 60))s || gcert)

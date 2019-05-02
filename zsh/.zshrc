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

# Mercurial secion causes slowness at Google when use Fig.
SPACESHIP_HG_SHOW=false
[ -f /etc/bash_completion.d/g4d ] && source /etc/bash_completion.d/g4d

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='hg files . 2> /dev/null; git ls-files . 2> /dev/null; fd --type f'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
# sort is required before uniq even though hg files and git ls-files output
# sorted lists because they can be out of order once filenames are removed. For
# example, [ "a/f.txt", "a/g/h.txt", "a/h.txt" ] -> [ "a", "a/b", "a" ].
export FZF_ALT_C_COMMAND='(hg files . 2> /dev/null; git ls-files . 2> /dev/null) | xargs -n 1 dirname | sort | uniq; fd --type d'

alias ssh='TERM=xterm-256color ssh'
# Open .zshrc to be edited in VS Code
alias change="$EDITOR ~/.zshrc"
# Re-run source command on .zshrc to update current terminal session with new settings
alias update='source ~/.zshrc'
# Vim: Load all modififed files in this mercurial repository into buffers.
alias vimhg='vim $(hg status --no-status --change .; hg status --no-status --added --modified --unknown)'
alias vimgit='vim $(git ls-files --modified --cached .)'

# A corp laptop needs gcert but has no access to source code. Thus, we cannot
# move the following `gcertstatus` to .zshrc_google.
gcertstatus -ssh_cert_comment="corp/normal" -check_remaining=$((8 * 60 * 60))s || prodaccess || gcert

source "${ZDOTDIR:-${HOME}}/.zshrc_`uname`"
[ -f ~/.zshrc_google ] && source ~/.zshrc_google

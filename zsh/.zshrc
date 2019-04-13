EDITOR=vim

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
export CLICOLOR=1

autoload -Uz compinit

# Open .zshrc to be edited in VS Code
alias change="$EDITOR ~/.zshrc"
# Re-run source command on .zshrc to update current terminal session with new settings
alias update="source ~/.zshrc"

source <(antibody init)

antibody bundle denysdovhan/spaceship-prompt
antibody bundle marzocchi/zsh-notify
antibody bundle zdharma/fast-syntax-highlighting
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-completions

source /etc/bash_completion.d/g4d
# Mercurial secion causes slowness at Google when use Fig.
SPACESHIP_HG_SHOW=false

# Appends every command to the history file once it is executed.
setopt inc_append_history
# Reloads the history whenever you use it.
setopt share_history

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='hg files'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
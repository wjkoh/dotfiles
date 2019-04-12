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
#antibody bundle dracula/zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

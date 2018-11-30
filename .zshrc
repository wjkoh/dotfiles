#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

if [ -x /usr/games/cowsay -a -x /usr/games/fortune ]; then
  /usr/games/fortune | /usr/games/cowsay
fi

# Make the GNOME terminal work with vim-colors-solarized.
if [ -z "$TMUX" ]; then
  case $COLORTERM in
    gnome-terminal)
      export TERM=xterm-256color
      ;;
  esac
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Google only.
if [ -f ~/.at_google ]; then
  source /etc/bash_completion.d/g4d

  autoload bashcompinit
  bashcompinit
  source /google/data/ro/projects/devtools/rebaser/bash_completion.sh

  # Aliases.
  alias screen="echo Use scrn instead."
  alias tmux="echo Use tmx2 instead."

  renew_gcert_if_needed() {
    HOURS_TILL_EOB=$((20 - $(date +%-H)))h
    gcertstatus -ssh_cert_comment=corp/normal -check_remaining=$HOURS_TILL_EOB || ~/bin/auth-refresh-gtunnel.py wjkoh0.mtv.corp.google.com
  }

  renew_gcert_if_needed
fi

# Set the Python startup file.
export PYTHONSTARTUP=$HOME/.pythonstartup

# Et cetera.
export REPORTTIME=1

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# FZF.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

set_root_dir() {
  ROOT_DIR=`git rev-parse --show-toplevel 2> /dev/null || hg root 2> /dev/null`
}

# Update g:project_dir_suffices in .vimrc as well.
export PROJECT_DIR_SUFFICES=('/google3/third_party/car/simulator/agentsim/')
set_project_dirs() {
  set_root_dir
  PROJECT_DIRS=(${ROOT_DIR}${^PROJECT_DIR_SUFFICES})
}

export FZF_DEFAULT_COMMAND='ag --nocolor --hidden --silent --ignore .git --ignore .svn --ignore .hg --ignore .DS_Store --ignore "**/*.pyc" -g ""'
export FZF_CTRL_T_COMMAND='set_project_dirs && '"$FZF_DEFAULT_COMMAND"' $PROJECT_DIRS . $HOME'
export FZF_ALT_C_COMMAND='set_project_dirs && bfs -nohidden -type d $PROJECT_DIRS . $HOME 2> /dev/null'

# Pipe Highlight to less.
export LESSOPEN="| highlight %s --out-format ansi --line-numbers --quiet --force"
export LESS=" -R"

alias less="less -m -N -g -i -J --line-numbers --underline-special"
alias more="less"

# Use "highlight" in place of "cat".
alias cat="highlight $1 --out-format ansi --line-numbers --quiet --force"

case `uname` in
    Darwin)
        # Use MacVim if it exists.
        if hash mvim &> /dev/null; then
            export EDITOR="mvim -v"
            alias vim="mvim -v"
        elif hash Vim &> /dev/null; then
            export EDITOR=Vim
            alias vim=Vim
        elif [ -f /Applications/MacVim.app/Contents/MacOS/Vim ]; then
            export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
            alias vim=/Applications/MacVim.app/Contents/MacOS/Vim
        fi

        # Back to My Mac (SSH).
        if [ -f ~/Dropbox/Mac\ Sync/.hostnames ]; then
            source ~/Dropbox/Mac\ Sync/.hostnames
        fi
        ;;
    Linux)
        # Aliases.
        if hash gnome-open &> /dev/null; then
          alias open=gnome-open
        elif hash gvfs-open &> /dev/null; then
          alias open=gvfs-open
        fi
        ;;
esac

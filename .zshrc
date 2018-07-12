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
fi

# Perforce and Piper.
if [ -n "$DISPLAY" ] ; then export G4MULTIDIFF=1 ; fi
export P4DIFF='bash -c "meld \${@/#:/--diff}" padding-to-occupy-argv0'
export P4MERGE='bash -c "chmod u+w \$1 ; meld \$2 \$1 \$3 ; cp \$1 \$4" padding-to-occupy-argv0'

# Set the Python startup file.
export PYTHONSTARTUP=$HOME/.pythonstartup

# Et cetera.
export REPORTTIME=1

# Base16 Shell.
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Fasd.
eval "$(fasd --init posix-alias zsh-hook)"

# FZF.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
FZF_CTRL_T_COMMAND="fasd -Ral | sed -r 's|^/google/src/cloud/[^/]+/[^/]+/google3/*||; /^$/d' | awk '!seen[\$0]++'"
FZF_CTRL_T_OPTS="-1 -0 --no-sort +m"

# vf - fuzzy open with vim from anywhere
# ex: vf word1 word2 ... (even part of a file name)
# zsh autoload function
vf() {
  local files
  if hash csearch &> /dev/null; then
    # TODO: Do we need to use --no-sort and/or --tac?
    files=(${(f)"$(csearch -i -l -local "$@"| sed -r "s|^${PWD}/*||" | fzf -1 -0 -m --preview-window=up:65% --preview="highlight {} --out-format ansi --line-numbers --quiet --force")"})
  else
    files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})
  fi
  if [[ -n $files ]]; then
     vim -- $files
     print -l $files[1]
  fi
}

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

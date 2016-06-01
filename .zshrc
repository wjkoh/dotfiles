#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

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

# Set up Autojump.
export AUTOJUMP_IGNORE_CASE=1
export AUTOJUMP_KEEP_SYMLINKS=1
source "${ZDOTDIR:-$HOME}/bin/autojump.plugin.zsh"

# Google only.
if [ -f ~/.at_google ]; then
  source /etc/bash_completion.d/g4d
fi

if [ -n "$DISPLAY" ] ; then export G4MULTIDIFF=1 ; fi
export P4DIFF='bash -c "meld \${@/#:/--diff}" padding-to-occupy-argv0'
export P4MERGE='bash -c "chmod u+w \$1 ; meld \$2 \$1 \$3 ; cp \$1 \$4" padding-to-occupy-argv0'

# Set the Python startup file.
export PYTHONSTARTUP=$HOME/.pythonstartup

# Et cetera.
export REPORTTIME=1

# Aliases.
alias matlab="matlab -nodesktop -nosplash"

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

        # Colorize default `ls` command.
        export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

        # Colorize GNU `ls` command.
        alias gls='gls --color=auto'
        DIRCOLORS=gdircolors

        # D-Bus for X11 applications such as Meld.
        launchctl unload -w /Library/LaunchAgents/org.freedesktop.dbus-session.plist
        launchctl load -w /Library/LaunchAgents/org.freedesktop.dbus-session.plist

        alias matlab="/Applications/MATLAB_R2014a.app/bin/matlab -nodesktop -nosplash"
        ;;
    Linux)
        # Colorize GNU `ls` command.
        DIRCOLORS=dircolors

        # Aliases.
        alias open=gnome-open
        ;;
esac
eval `$DIRCOLORS ~/.dircolors-solarized/dircolors.ansi-universal`

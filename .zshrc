# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="blinks"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(vi-mode osx macports autojump cp rsync mosh python pip git mercurial svn)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# * Key settings
bindkey -v
bindkey ^R history-incremental-search-backward

# * Set Environment Variables
# Locales
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# EDITOR
export EDITOR=vim
export VISUAL=vim

# autojump installed via MacPorts
export FPATH="$FPATH:/opt/local/share/zsh/site-functions/"
if [ -f /opt/local/etc/profile.d/autojump.zsh ]; then
    . /opt/local/etc/profile.d/autojump.zsh
fi
autoload -U compinit; compinit -u
export AUTOJUMP_IGNORE_CASE=1
export AUTOJUMP_KEEP_SYMLINKS=1

# Python startup file
export PYTHONSTARTUP=$HOME/.pythonstartup

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
mkdir -p $WORKON_HOME
source virtualenvwrapper.sh

# Et cetera
export REPORTTIME=1

# * Aliases
alias matlab="matlab -nodesktop -nosplash"

alias -s md=vim
alias -s tex=vim
alias -s cpp=vim
alias -s h=vim
alias -s html=safari

alias tmux="TERM=screen-256color-bce tmux"
case `uname` in
    Darwin)
        # Use MacVim if it exists
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

        # Back to My Mac (SSH)
        if [ -f ~/Dropbox/Mac\ Sync/.hostnames ]; then
            source ~/Dropbox/Mac\ Sync/.hostnames
        fi

        # Colorize default `ls` command
        export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

        # Colorize GNU `ls` command
        alias gls='gls --color=auto'
        DIRCOLORS=gdircolors
        ;;
    Linux)
        # Colorize GNU `ls` command
        DIRCOLORS=dircolors
        ;;
esac
eval `$DIRCOLORS ~/.dircolors-solarized/dircolors.ansi-universal`

# http://stackoverflow.com/questions/9810327/git-tab-autocompletion-is-useless-can-i-turn-it-off-or-optimize-it/9810485#9810485
__git_files () {
    _wanted files expl 'local files' _files
}

# D-Bus for X11 applications, such as Meld
launchctl unload -w /Library/LaunchAgents/org.freedesktop.dbus-session.plist
launchctl load -w /Library/LaunchAgents/org.freedesktop.dbus-session.plist

# Initiate tmux
if hash tmux &> /dev/null && [ -z "$TMUX" ]; then
    SESSION=$USER
    tmux has-session -t $SESSION
    if [ $? -eq 0 ]; then
        #echo "Session $SESSION already exists. Attaching."
        #sleep 1
        tmux new-session -t $SESSION \; set-option destroy-unattached on
    else
        tmux new-session -s $SESSION
    fi
fi
# DO NOT ADD ANY CONFIGURATION BELOW THIS LINE.

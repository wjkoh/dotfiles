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
plugins=(git mercurial autojump brew cloudapp debian macports osx python pip svn vi-mode)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# Set locales
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# autojump installed via MacPorts
export FPATH="$FPATH:/opt/local/share/zsh/site-functions/"
if [ -f /opt/local/etc/profile.d/autojump.sh ]; then
	. /opt/local/etc/profile.d/autojump.sh
fi

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
mkdir -p WORKON_HOME
source virtualenvwrapper.sh

# Use MacVim if it exists
if hash mvim &> /dev/null; then
	export EDITOR="mvim -v"
	alias vim="mvim -v"
elif [ -f /Applications/MacVim.app/Contents/MacOS/Vim ]; then
	export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
	alias vim=/Applications/MacVim.app/Contents/MacOS/Vim
fi

# tmux
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

# Back to My Mac (SSH)
if [ -f ~/Dropbox/Mac\ Sync/.hostnames ]; then
    source ~/Dropbox/Mac\ Sync/.hostnames
fi

# MATLAB
alias matlab="/Applications/MATLAB_R2011b.app/bin/matlab -nodesktop -nosplash"

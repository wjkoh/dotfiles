#!/bin/sh

xcodebuild -license
sudo xcodebuild -license

# Back to My Mac (SSH)
HOSTNAME=`hostname -s`
HOSTNAME_CLEANED=${HOSTNAME//-/_}
EXPORT_STMT="export $HOSTNAME_CLEANED=$HOSTNAME.`echo show Setup:/Network/BackToMyMac | scutil | sed -n 's/.* : *\(.*\).$/\1/p'`"
HOSTNAMES_FILE="$HOME/Dropbox/Mac Sync/.hostnames"

if ! grep "$EXPORT_STMT" "$HOSTNAMES_FILE" > /dev/null; then
    echo $EXPORT_STMT >> $HOSTNAMES_FILE
fi

# Update MacPorts
sudo port selfupdate
sudo port upgrade outdated

# Install compilers and utilities
sudo port install autojump
sudo port install ccache
sudo port install ctags
sudo port install gcc47
sudo port install tig
sudo port install weechat +aspell +perl +python +tls
sudo port install wget
sudo cpan App::Ack

# tmux
sudo port install tmux
git clone https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard.git
cd tmux-MacOSX-pasteboard
make reattach-to-user-namespace && sudo cp reattach-to-user-namespace /opt/local/bin
cd ..
rm -rf tmux-MacOSX-pasteboard

# Install libraries
sudo port install glew
#sudo port install jpeg
#sudo port install freetype

# Install MacVim

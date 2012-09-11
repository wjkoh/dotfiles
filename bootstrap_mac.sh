#!/bin/sh

xcodebuild -license
sudo xcodebuild -license

sudo port selfupdate
sudo port install autojump
sudo port install ccache
sudo port install ctags
sudo port install gcc47
sudo port install tig

sudo port install tmux
git clone https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard.git
cd tmux-MacOSX-pasteboard
make reattach-to-user-namespace && sudo cp reattach-to-user-namespace /opt/local/bin
cd ..
rm -rf tmux-MacOSX-pasteboard

sudo port install weechat +aspell +perl +python +tls
sudo port install wget
sudo cpan App::Ack

sudo port install glew
sudo port install jpeg
sudo port install freetype

# install MacVim

# Back to My Mac (SSH)
HOSTNAME=`hostname -s`
HOSTNAME_CLEANED=${HOSTNAME//-/_}
ICLOUD_DOMAIN=`echo show Setup:/Network/BackToMyMac | scutil | sed -n 's/.* : *\(.*\).$/\1/p'`
EXPORT_STMT="export $HOSTNAME_CLEANED=$HOSTNAME.$ICLOUD_DOMAIN"
HOSTNAMES_FILE="$HOME/Dropbox/Mac Sync/.hostnames"

if ! grep "$EXPORT_STMT" "$HOSTNAMES_FILE" > /dev/null; then
    echo $EXPORT_STMT >> $HOSTNAMES_FILE
fi

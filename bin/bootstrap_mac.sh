#!/usr/bin/env bash

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

# http://mercurial.selenic.com/wiki/CACertificates
echo
echo "* Generating a dummy certificate..."
if [ ! -f /etc/hg-dummy-cert.pem ]; then
    openssl req -new -x509 -extensions v3_ca -keyout /dev/null -out dummycert.pem -days 3650
    sudo mv dummycert.pem /etc/hg-dummy-cert.pem
fi

# Update MacPorts
sudo port selfupdate
sudo port upgrade outdated

# Install compilers and utilities
sudo port install autojump
sudo port install boost
sudo port install ccache
sudo port install ctags
sudo port install gcc47
sudo port install tig
sudo port install weechat +aspell +perl +python +tls
sudo port install wget
sudo /usr/bin/cpan App::Ack

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
#sudo port install libpng

# Install MacVim

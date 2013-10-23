#!/usr/bin/env bash

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
sudo port selfupdate || exit
sudo port upgrade outdated  # It can fail.

# Install compilers
sudo port install gcc48 || exit
sudo ln -sf /opt/local/bin/gfortran-mp-4.8 /opt/local/bin/gfortran || exit

# Install utilities
sudo port install autojump || exit
sudo port install ccache || exit
sudo port install coreutils || exit
sudo port install ctags || exit
sudo port install git-core || exit
sudo port install htop || exit
sudo port install meld || exit
sudo port install mosh || exit
sudo port install tmux libmpdclient || exit
sudo port install tmux-pasteboard
sudo port install weechat +aspell +perl +python +tls || exit
sudo port install wget || exit

# Install libraries
sudo port install boost || exit
sudo port install freetype || exit
sudo port install glew || exit
sudo port install glm || exit
sudo port install jpeg || exit
sudo port install libpng || exit

# Install MacVim

echo
echo "* SUCCESSFULLY DONE!"

sudo port install nethack +autopickup_exceptions +menucolors
wget http://dayoneapp.com/downloads/dayone-cli.pkg && open dayone-cli.pkg
wget https://gist.github.com/raw/1838072/Monaco-Powerline.otf --no-check-certificate && open Monaco-Powerline.otf

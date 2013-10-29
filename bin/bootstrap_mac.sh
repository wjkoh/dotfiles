#!/usr/bin/env bash

sudo xcodebuild -license

# Update MacPorts
sudo port selfupdate || exit
sudo port upgrade outdated  # It might fail.

# Install compilers
sudo port install gcc48 || exit
sudo ln -sf /opt/local/bin/gfortran-mp-4.8 /opt/local/bin/gfortran || exit

# Install utilities
sudo port install autojump || exit
sudo port install ccache || exit
sudo port install coreutils || exit
sudo port install ctags || exit
sudo port install ffmpeg || exit
sudo port install git-core || exit
sudo port install htop || exit
sudo port install meld || exit
sudo launchctl load -w /Library/LaunchDaemons/org.freedesktop.dbus-system.plist
launchctl load -w /Library/LaunchAgents/org.freedesktop.dbus-session.plist
sudo port install mosh || exit
sudo port install tig || exit
sudo port install tmux libmpdclient || exit
sudo port install tmux-pasteboard
sudo port install weechat +aspell +perl +python +tls || exit
sudo port install wget || exit

# Install libraries
# Do not mix libc++ and libstdc++. http://www.alecjacobson.com/weblog/?p=3145
sudo port -ns install boost configure.compiler=macports-gcc-4.8 || exit
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

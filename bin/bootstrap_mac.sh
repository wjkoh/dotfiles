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
sudo port install x264 +asm ffmpeg || exit
sudo port install git-core +bash_completion +svn || exit
sudo port install htop || exit
sudo port install meld || exit
sudo port install mosh || exit
sudo port install tig || exit
sudo port install tmux libmpdclient || exit
sudo port install tmux-pasteboard
sudo port install weechat +aspell +perl +python +tls || exit
sudo port install wget || exit
sudo port install swig swig-python || exit  # for SciPy
sudo port install pigz || exit

# Install libraries
# Do not mix libc++ and libstdc++. http://www.alecjacobson.com/weblog/?p=3145
sudo port -ns install boost configure.compiler=macports-gcc-4.8 || exit
#sudo port activate boost @1.54.0  # for ARCSim

sudo port install freetype || exit
sudo ln -s /opt/local/include/freetype2 /opt/local/include/freetype  # for PIL

sudo port install glew || exit
sudo port install glfw || exit
sudo port install glm || exit
sudo port install jpeg || exit
sudo port install libpng || exit
sudo port install suitesparse || exit

# Install MacVim

echo
echo "* SUCCESSFULLY DONE!"

sudo port install nethack +autopickup_exceptions +menucolors
wget http://dayoneapp.com/downloads/dayone-cli.pkg -P /tmp/ && open /tmp/dayone-cli.pkg

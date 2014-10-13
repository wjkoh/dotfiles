#!/usr/bin/env bash

sudo xcodebuild -license

# Update MacPorts
sudo port selfupdate || exit
sudo port upgrade outdated  # It might fail, so don't add `|| exit`.

# Change default Python installation
sudo port install python27
sudo port select python python27
sudo port install py27-pip
sudo port select pip pip27
sudo port install py27-ipython +notebook
sudo port select ipython ipython27
rehash

# Install compilers
sudo port install gcc48 || exit
sudo ln -sf /opt/local/bin/gfortran-mp-4.8 /opt/local/bin/gfortran || exit

# Install utilities
sudo port install aspell-dict-en || exit
sudo port install autojump || exit
sudo port install ccache || exit
sudo port install coreutils || exit
sudo port install ctags || exit
sudo port install git-core +bash_completion +svn || exit
sudo port install htop || exit
sudo port install imagemagick || exit
sudo port install macvim +python +breakindent || exit
sudo port install meld || exit
sudo port install mosh || exit
sudo port install pigz || exit
sudo port install s3cmd || exit
sudo port install swig swig-python || exit  # for SciPy
sudo port install the_silver_searcher || exit
sudo port install tig || exit
sudo port install tmux libmpdclient || exit
sudo port install tmux-pasteboard
sudo port install weechat +aspell +perl +python +tls || exit  # Install aspell-dict-en as well.
sudo port install wget || exit
sudo port install x264 +asm ffmpeg || exit

# Install libraries
# Do not mix libc++ and libstdc++. http://www.alecjacobson.com/weblog/?p=3145
# sudo port -ns upgrade --force boost configure.compiler=macports-gcc-4.8 || exit
sudo port -ns install boost configure.compiler=macports-gcc-4.8 || exit
sudo port install anttweakbar || exit
sudo port install assimp || exit
sudo port install ceres-solver || exit
sudo port install freetype || exit
sudo port install glew || exit
sudo port install glfw || exit
sudo port install glm || exit
sudo port install jpeg || exit
sudo port install libevent || exit  # for gevent/bokeh
sudo port install libpng || exit
sudo port install opencv +python27 || exit
sudo port install suitesparse || exit

# for Matplotlib and PIL. Pillow is okay?
sudo ln -s /opt/local/include/freetype2 /opt/local/include/freetype

# Install MacVim
open https://github.com/b4winckler/macvim/releases

# Install XQuartz
open -a X11

echo
echo "* SUCCESSFULLY DONE!"

# Optionals.
# Installs NetHack.
sudo port install nethack +autopickup_exceptions +menucolors

# Installs DayOne CLI.
wget http://dayoneapp.com/downloads/dayone-cli.pkg -P /tmp/ && open /tmp/dayone-cli.pkg

# Installs Dandy.
curl https://raw.githubusercontent.com/EBvi/dandy/master/bin/uninstall.sh | sh
curl https://raw.githubusercontent.com/EBvi/dandy/master/bin/install.sh | sh
